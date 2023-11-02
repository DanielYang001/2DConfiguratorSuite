window.embedPanoramaView = (flutter_image) => {
console.log(pannellum);

pannellum.viewer('panorama', {
    "type": "equirectangular",
    "panorama": "https://pannellum.org/images/alma.jpg"
});

}