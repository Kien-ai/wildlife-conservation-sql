-- Rank Protected Areas by Number of Incidents
SELECT 
    p.area_name,
    COUNT(pi.incident_id) AS total_incidents,
    RANK() OVER (ORDER BY COUNT(pi.incident_id) DESC) AS risk_rank
FROM protected_areas p
LEFT JOIN poaching_incidents pi 
    ON p.area_id = pi.area_id
GROUP BY p.area_id;

-- Severity Distribution by Park
SELECT 
    p.area_name,
    pi.severity,
    COUNT(*) AS incident_count
FROM poaching_incidents pi
JOIN protected_areas p 
    ON pi.area_id = p.area_id
GROUP BY p.area_name, pi.severity
ORDER BY p.area_name;

-- Most Targeted Species
SELECT 
    species,
    COUNT(*) AS total_animals,
    SUM(CASE WHEN status = 'Injured' THEN 1 ELSE 0 END) AS injured_count,
    SUM(CASE WHEN status = 'Missing' THEN 1 ELSE 0 END) AS missing_count
FROM animals
GROUP BY species
ORDER BY injured_count + missing_count DESC;

-- Monthly Incident Trend
SELECT 
    DATE_FORMAT(incident_date, '%Y-%m') AS month,
    COUNT(*) AS total_incidents
FROM poaching_incidents
GROUP BY month
ORDER BY month;


-- risk_score = 0.4 * normalized_incident_count +
-- 0.4 * normalized_severity_score +
-- 0.2 * normalized_animals_affected

-- RIsk Analysis

WITH park_incidents AS (
    SELECT 
        p.area_id,
        p.area_name,
        COUNT(pi.incident_id) AS incident_count,
        SUM(
            CASE pi.severity
                WHEN 'Low' THEN 1
                WHEN 'Medium' THEN 2
                WHEN 'High' THEN 3
                WHEN 'Critical' THEN 4
            END
        ) AS severity_score
    FROM protected_areas p
    LEFT JOIN poaching_incidents pi
        ON p.area_id = pi.area_id
    GROUP BY p.area_id
),
park_animals AS (
    SELECT 
        protected_area_id,
        SUM(CASE WHEN status IN ('Injured','Missing') THEN 1 ELSE 0 END) AS affected_animals
    FROM animals
    GROUP BY protected_area_id
),
-- Combine
combined AS (
    SELECT 
        pi.area_id,
        pi.area_name,
        pi.incident_count,
        pi.severity_score,
        IFNULL(pa.affected_animals,0) AS affected_animals
    FROM park_incidents pi
    LEFT JOIN park_animals pa
        ON pi.area_id = pa.protected_area_id
)
SELECT 
    area_name,
    incident_count,
    severity_score,
    affected_animals,
    -- Normalize each factor
    ROUND( (incident_count / (SELECT MAX(incident_count) FROM combined))*0.4
           + (severity_score / (SELECT MAX(severity_score) FROM combined))*0.4
           + (affected_animals / (SELECT MAX(affected_animals) FROM combined))*0.2, 2) AS risk_score
FROM combined
ORDER BY risk_score DESC;

