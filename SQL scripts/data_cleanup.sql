-- USDA Production Data Cleanup

UPDATE	cheese_production SET value = REPLACE(value, ',', '');

UPDATE	honey_production SET value = REPLACE(value, ',', '');

UPDATE	milk_production SET value = REPLACE(value, ',', '');

UPDATE	coffee_production SET value = REPLACE(value, ',', '');

UPDATE	egg_production SET value = REPLACE(value, ',', '');

UPDATE	yogurt_production SET value = REPLACE(value, ',', '');