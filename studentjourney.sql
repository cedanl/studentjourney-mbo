SELECT distinct
    d.deelnemernummer,
    v.begindatum,
    v.einddatum,
    v.volgnummer,
    coalesce(te.niveau,v.MBONIVEAU) as niveau,
    te.naam AS crebo_naam,
    te.beroepsopleidingid AS BC_code,
    oe.naam AS Team,
    oep.naam AS College,
    oegp.naam AS Cluster,
	  r.geslaagd
FROM verbintenis v
INNER JOIN deelnemer d ON d.id = v.deelnemer
INNER JOIN opleiding o ON v.opleiding = o.id  
INNER JOIN opleidingcohort oc ON v.cohort = oc.cohort AND v.opleiding = oc.opleiding
INNER JOIN taxonomieelement te ON oc.verbintenisgebied = te.id 
INNER JOIN organisatieeenheid oe ON v.organisatieeenheid = oe.id
INNER JOIN organisatieeenheid oep ON oe.parent = oep.id
INNER JOIN organisatieeenheid oegp ON oep.parent = oegp.id
LEFT JOIN redenuitschrijving r ON r.id = v.redenuitschrijving
WHERE v.status IN ('Definitief', 'Beeindigd', 'Volledig', 'Afgedrukt')
  AND o.LEERWEG in ('BOL', 'BBL') 
  AND v.begindatum >= '2018-08-01'
ORDER BY d.deelnemernummer, v.begindatum;