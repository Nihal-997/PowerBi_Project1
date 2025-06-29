CREATE TABLE energy_source_share (
    country VARCHAR(50),
    year INT,
    coal_share_prod float,
    gas_share_prod float,
    hydro_share_prod float,
    solar_share_prod float,
    wind_share_prod float,
    oil_share_prod float,
    nuclear_share_prod float,
    other_renewables_prod float,
    bioenergy_share_prod float
);

select * from energy_source_share


CREATE TABLE energy_generation (
    country VARCHAR(50),
    year INT,
    other_renewables float,
    bioenergy_generation float,
    solar_generation float,
    wind_generation float,
    hydro_generation float,
    nuclear_generation float,
    oil_generation float,
    gas_generation float,
    coal_generation float
);

select * from energy_generation

CREATE TABLE percapita_energy_generation (
    country VARCHAR(50),
    year INT,
    percapita_coal_generation_kwh float,
    percapita_gas_generation_kwh float,
    percapita_oil_generation_kwh float,
    percapita_nuclear_generation_kwh float,
    percapita_hydro_generation_kwh float,
    percapita_wind_generation_kwh float,
    percapita_solar_generation_kwh float,
    percapita_bioenergy_generation_kwh float,
    percapita_other_renewables_kwh float
);

select * from percapita_energy_generation

CREATE TABLE percapita_elec_fossil_nuclear_renew (
    country VARCHAR(50),
    year INT,
    percapita_fossil_generation_kwh NUMERIC,
    percapita_nuclear_generation_kwh NUMERIC,
    percapita_renewable_generation_kwh NUMERIC
);

select * from percapita_elec_fossil_nuclear_renew 


CREATE TABLE electricity_share (
    country VARCHAR(50),
    year INT,
    nuclear_share_of_electricity float,
    fossil_share_of_electricity float,
    renewable_share_of_electricity float
);

select * from electricity_share

CREATE TABLE electricity_low_carbon_share (
    country VARCHAR(50),
    year INT,
    low_carbon_share_of_electricity float
);

select * from electricity_low_carbon_share


CREATE TABLE primary_energy_consumption (
    country VARCHAR(50),
    year INT,
    primaryenergy_consu_percapita_kwh float
);

select * from primary_energy_consumption


CREATE TABLE coal_production_share (
    country VARCHAR(50),
    year INT,
    coal_share_prod float
);


CREATE TABLE gas_production_share (
    country VARCHAR(50),
    year INT,
    gas_share_prod float
);

CREATE TABLE hydro_production_share (
    country VARCHAR(50),
    year INT,
    hydro_share_prod NUMERIC(10,5)
);

CREATE TABLE solar_production_share (
    country VARCHAR(50),
    year INT,
    solar_share_prod float
);

CREATE TABLE wind_production_share (
    country VARCHAR(50),
    year INT,
    wind_share_prod float
);

CREATE TABLE oil_production_share (
    country VARCHAR(50),
    year INT,
    oil_share_prod float
);

CREATE TABLE nuclear_production_share (
    country VARCHAR(50),
    year INT,
    nuclear_share_prod float
);

CREATE TABLE renewable_production_share (
    country VARCHAR(50),
    year INT,
    renewable_share_prod NUMERIC(10,5)
);

CREATE TABLE bioenergy_production_share (
    country VARCHAR(50),
    year INT,
    bioenergy_share_prod float
);



CREATE TABLE All_Energy_Data AS
SELECT
    ess.country,
    ess.year,

    -- energy_source_share
    ess.coal_share_prod,
    ess.gas_share_prod,
    ess.hydro_share_prod,
    ess.solar_share_prod,
    ess.wind_share_prod,
    ess.oil_share_prod,
    ess.nuclear_share_prod,
    ess.other_renewables_prod,
    ess.bioenergy_share_prod,

    -- energy_generation
    eg.other_renewables,
    eg.bioenergy_generation,
    eg.solar_generation,
    eg.wind_generation,
    eg.hydro_generation,
    eg.nuclear_generation,
    eg.oil_generation,
    eg.gas_generation,
    eg.coal_generation,

    -- percapita_energy_generation
    peg.percapita_coal_generation_kwh,
    peg.percapita_gas_generation_kwh,
    peg.percapita_oil_generation_kwh,
    -- Remove or rename this line if you want the other version instead:
    peg.percapita_nuclear_generation_kwh AS percapita_nuclear_kwh_energy_gen,
    peg.percapita_hydro_generation_kwh,
    peg.percapita_wind_generation_kwh,
    peg.percapita_solar_generation_kwh,
    peg.percapita_bioenergy_generation_kwh,
    peg.percapita_other_renewables_kwh,

    -- percapita_elec_fossil_nuclear_renew
    pfnr.percapita_fossil_generation_kwh,
    -- Avoid duplicate name or alias it differently if keeping both
    pfnr.percapita_nuclear_generation_kwh AS percapita_nuclear_kwh_fossil_renew,
    pfnr.percapita_renewable_generation_kwh,

    -- electricity_share
    es.nuclear_share_of_electricity,
    es.fossil_share_of_electricity,
    es.renewable_share_of_electricity,

    -- electricity_low_carbon_share
    elcs.low_carbon_share_of_electricity,

    -- primary_energy_consumption
    pec.primaryenergy_consu_percapita_kwh

FROM energy_source_share ess
LEFT JOIN energy_generation eg ON ess.country = eg.country AND ess.year = eg.year
LEFT JOIN percapita_energy_generation peg ON ess.country = peg.country AND ess.year = peg.year
LEFT JOIN percapita_elec_fossil_nuclear_renew pfnr ON ess.country = pfnr.country AND ess.year = pfnr.year
LEFT JOIN electricity_share es ON ess.country = es.country AND ess.year = es.year
LEFT JOIN electricity_low_carbon_share elcs ON ess.country = elcs.country AND ess.year = elcs.year
LEFT JOIN primary_energy_consumption pec ON ess.country = pec.country AND ess.year = pec.year;


select * from All_Energy_Data
