import mapboxgl from 'mapbox-gl';
import MapboxGeocoder from '@mapbox/mapbox-gl-geocoder';

const buildMap = (mapElement) => {
  mapboxgl.accessToken = mapElement.dataset.mapboxApiKey;
  return new mapboxgl.Map({
    container: 'map',
    style: 'mapbox://styles/mapbox/streets-v11'
  });
};

const buildSearchBar = (searchBarElement) => {
  mapboxgl.accessToken = searchBarElement.dataset.mapboxApiKey;
  // window.alert("Bonjour !");
  return new MapboxGeocoder({
    accessToken: mapboxgl.accessToken,
    mapboxgl: mapboxgl })
}

const addMarkersToMap = (map, markers) => {
  markers.forEach((marker) => {
    const popup = new mapboxgl.Popup().setHTML(marker.infoWindow);
    new mapboxgl.Marker()
      .setLngLat([ marker.lng, marker.lat ])
      .setPopup(popup)
      .addTo(map);
  });
};

const addPositionToMap = (map, pos) => {
  var crd = pos.coords;
  new mapboxgl.Marker()
      .setLngLat([ crd.longitude, crd.latitude ])
      .addTo(map);
}

// const fitMapToMarkers = (map, markers) => {
//   const bounds = new mapboxgl.LngLatBounds();
//   markers.forEach(marker => bounds.extend([ marker.lng, marker.lat ]));
//   map.fitBounds(bounds, { padding: 70, maxZoom: 15, duration: 0 });
// };

function success(pos) {
  var crd = pos.coords;
  position = [crd.latitude, crd.longitude]

  // console.log('Votre position actuelle est :');
  // console.log(`Latitude : ${crd.latitude}`);
  // console.log(`Longitude : ${crd.longitude}`);
  // console.log(`La précision est de ${crd.accuracy} mètres.`);
}

const initMapbox = () => {
  const mapElement = document.getElementById('map');
  const geocoderElement = document.getElementById('geocoder');
  // if ("geolocation" in navigator) {
  //   navigator.geolocation.getCurrentPosition(addPositionToMap());
  // }
  if (mapElement) {
    const map = buildMap(mapElement);
    var geolocate = new mapboxgl.GeolocateControl({
      positionOptions: {
        enableHighAccuracy: true
      },
      trackUserLocation: true
    });
    // Add the control to the map.
    map.addControl(geolocate);
    map.on('load', function() {
      geolocate.trigger();
    });
    const markers = JSON.parse(mapElement.dataset.markers);
    addMarkersToMap(map, markers);
    // fitMapToMarkers(map, markers);
    const geocoder = buildSearchBar(geocoderElement);
    document.getElementById('geocoder').appendChild(geocoder.onAdd(map));
  }
};

export { initMapbox };
