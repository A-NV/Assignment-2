-- Question 3a [5 marks] sql code below
  select personID, name, email 
  from person 
  order by email asc;

-- Question 3b [5 marks] sql code below
select personID, name, email 
from person
where email LIKE 'g%' or name LIKE '%a%';

-- Question 3c [5 marks] sql code below
 select r.routeID, r.routeName, r.estimatedWalkingTime, rst.dayAndTimeStart 
 from route as r
 join routeStartTime as rst on r.routeID = rst.routeID;

-- Question 3d [5 marks] sql code below
select p.personID, p.name, p.email, count(plan.planID) as numberOfPlans from plan 
right join person as p on plan.isCreatedBy = p.personID
Group by p.personID
order by count(plan.planID) desc;


-- Question 3e [5 marks] sql code below
select poi.pointOfInterestID, poi.typeOfPOI, poi.name, count(vw.locationID) as numberOfLocationsViewableFrom
from pointofinterest as poi 
left join viewinginstructions as vw on poi.pointOfInterestID = vw.pointOfInterestID
group by poi.pointOfInterestID
order by count(vw.locationID) desc;

-- Question 3f [5 marks] sql code below
select distinct l.locationID, l.Name 
from location l 
left join waypoint w on l.locationID = w.locationID
left join route r on l.locationID = r.startsAt
where w.locationID is null and r.startsAt is null and r.endsAt is null;

-- Question 3g [10 marks] sql code below
select poi.pointofinterestID, poi.name, poi.typeOfPOI 
from pointofinterest poi 
where poi.pointOfInterestID not in (
select distinct pls.locationID 
from plannedlocationselection pls
);

-- Question 3h [10 marks] sql code below

select l.locationID, l.name,  0 as arrivalTime
from location l 
join route r on l.locationID = r.startsAt
where r.routeID = 3

union all 

select w.locationID, l.name, w.relativeArrivalTime as arrivalTime 
from location l 
join waypoint w on l.locationID = w.locationID 
where w.routeID = 3 

union all 

select l.locationID, l.name, r.estimatedWalkingTime as arrivalTime
from location l
join route r on l.locationID = r.endsAt 
where r.routeID = 3
order by arrivalTime;


