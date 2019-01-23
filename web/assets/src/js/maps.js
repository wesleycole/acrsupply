import { stores } from './stores';

export const initMap = element => {
  const center = { lat: 35.684811, lng: -79.297692 };
  const map = new google.maps.Map(element, { zoom: 7, center });
  stores.forEach((store) => addMapMarker(store, map));
};

export const addMapMarker = (store, map) => {
  const {position } = store;
  const window = new google.maps.InfoWindow({
    content: generateWindowContent(store)
  });
  const marker = new google.maps.Marker({ position, map });
  marker.addListener('click', () => displayWindow(window, map, marker));
};

const displayWindow = (window, map, marker) => {
  window.open(map, marker);
}

const generateWindowContent = ({ title, address, phone }) => {
  return `
    <span style="font-weight: bold; display: block; margin-bottom: 5px;">${title}</span>
    <span>${address}</span><br />
    <span>${phone}</span>
  `;
}
