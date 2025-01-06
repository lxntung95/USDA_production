/* Data Scientist working at the USDA.
 * 
 * Department tracks the production of various agricultural commodities across different states.
 * The datasets include: milk, cheese, coffee, honey, and yogurt production as well as a state lookup table.
 * The data spans multiple years and states, with varying levels of production for each commodity.
 * The request is to generate insights from this data to aid in future planning and decision-making by:
 * 	- Assessing state-by-state production for each commodity.
 * 	- Identify trends or anomalies.
 * 	- Offer data-backed suggestions for areas that may need more attention.
 * 
 */

/*
 * Find the Total Milk Production for Year 2023.
 * This information will be put into the yearly report.
 */
SELECT SUM(Value)	FROM milk_production	WHERE Year = 2023;

/*
 * Find states with Cheese Production greater than 100mm in April 2023.
 * The Cheese Department wants to focus marketing efforts there.
 */
SELECT	sl.State,
		cp.Value,
		cp.Period,
		cp.Year
FROM	state_lookup sl INNER JOIN cheese_production cp
ON		sl.State_ANSI = cp.State_ANSI
WHERE 	cp.Period = 'APR' AND cp.Year = 2023;

/*
 * Find the Total Value of Coffee Production for 2011.
 * Want to know how Coffee Production has changed over the years.
*/
SELECT Year, SUM(Value)	FROM coffee_production	WHERE Year = 2011;

/*
 * Find the Average Honey Production for Year 2022.
 * Prepare for a meeting with the Honey Council.
*/
SELECT Year, AVG(Value)	FROM honey_production	WHERE Year = 2022;

/*
 * Find the State_ANSI code for Florida.
 * The State Relations team wants a list of all state names and corresponding ANSI codes.
*/
SELECT State, State_ANSI	FROM state_lookup	WHERE State = 'FLORIDA';

/*
 * For a cross-commodity report, list all the states with their cheese production values even if they did not produce any.
*/
SELECT	sl.State,
		SUM(cp.Value),
		cp.Period,
		cp.Year
FROM	state_lookup sl LEFT JOIN cheese_production cp
ON		sl.State_ANSI = cp.State_ANSI AND cp.Year = 2023 AND cp.Period = 'APR'
GROUP By	sl.State;

/*
 * Find the Total Yogurt Production for States in the Year 2022 who also have Cheese Production Data in 2023.
 * This will help the Dairy Division in their planning.
*/
SELECT 	yp.Year,
		SUM(yp.Value)
FROM	yogurt_production yp
WHERE	yp.Year = 2022 AND yp.State_ANSI IN (
	SELECT DISTINCT cp.State_ANSI	FROM cheese_production cp	WHERE cp.Year = 2023
);

/*
 * List all states from state_lookup that are missing from milk_production in the Year 2023.
 */
SELECT	sl.State,
		mp.Year,
		SUM(mp.Value) AS Total_Milk
FROM	state_lookup sl LEFT JOIN milk_production mp 
ON		sl.State_ANSI = mp.State_ANSI AND mp.Year = 2023
GROUP BY	sl.State
HAVING	Total_Milk IS NULL
ORDER BY 	sl.State;

/*
 * Find the Average Coffee Production for all years where the honey production exceeded 1mm.
*/
SELECT	AVG(cp.Value)
FROM	coffee_production cp
WHERE	cp.Year IN (
	SELECT hp.Year	FROM honey_production hp	WHERE hp.Value > 1000000
);