import Typed from 'typed.js';

const loadDynamicBannerText = () => {
  new Typed('#banner-typed-text', {
    strings: ["Eat cheese", "For a better life !"],
    typeSpeed: 70,
    loop: true
  });
}

export { loadDynamicBannerText };
