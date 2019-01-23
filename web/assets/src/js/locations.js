import { initMap } from "./maps";

(function() {
  const mapElement = document.getElementById("locations-map");
  if (mapElement) {
    initMap(mapElement);
  }
})();