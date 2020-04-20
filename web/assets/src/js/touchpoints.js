import { CountUp } from "countup.js";

(function () {
  fetch(
    "https://v2-api.sheety.co/011deb83da15c598545e44f2f0c4609d/acrSupplyTouchPoints/totals"
  )
    .then((response) => {
      return response.json();
    })
    .then(({ totals }) => {
      const dataPoint = totals[0];
      const {
        pamphlets,
        theStory,
        volunteerHours,
        volunteerPeopleImpact,
      } = dataPoint;

      var pamphletsCount = new CountUp("pamphletsTouchpoint", pamphlets);
      pamphletsCount.start();

      var theStoryCount = new CountUp("theStoryTouchpoint", theStory);
      theStoryCount.start();

      var volunteerHoursCount = new CountUp(
        "volunteerHoursTouchpoint",
        volunteerHours
      );
      volunteerHoursCount.start();

      var volunteerPeopleImpactCount = new CountUp(
        "volunteerPeopleImpactedTouchpoint",
        volunteerPeopleImpact
      );
      volunteerPeopleImpactCount.start();
    });
})();
