import Typed from 'typed.js';

const loadDynamicBannerText = () => {
  if(document.querySelector('#banner-typed-text')) {
    new Typed('#banner-typed-text', {
      strings: ["Eat cheese", "For a better life !"],
      typeSpeed: 70,
      loop: true
    });
  }
}

export { loadDynamicBannerText };
