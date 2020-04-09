explain (analyze on,buffers on,verbose off,costs on,timing on)
SELECT
	companycon0_.id AS id1_233_,
	companycon0_.company_id AS company_5_233_,
	companycon0_.config_name AS config_n2_233_,
	companycon0_.config_type AS config_t3_233_,
	companycon0_.config_value AS config_v4_233_
FROM
	go_company_configs companycon0_
LEFT OUTER JOIN go_companies company1_ ON
	companycon0_.company_id = company1_.id
WHERE
	company1_.id = '123'
	AND companycon0_.config_type = 'PUBLIC'
	AND companycon0_.config_name = 'config'
