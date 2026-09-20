const lightbox = document.querySelector('.lightbox');
const lightboxImage = lightbox.querySelector('img');
const lightboxTitle = lightbox.querySelector('#lightbox-title');
const lightboxCount = lightbox.querySelector('.lightbox-count');
const lightboxButtons = [...document.querySelectorAll('[data-lightbox-src]')];
const previousButton = lightbox.querySelector('.lightbox-prev');
const nextButton = lightbox.querySelector('.lightbox-next');
let currentGalleryButtons = [];
let currentIndex = 0;

function showImage(index) {
  currentIndex = (index + currentGalleryButtons.length) % currentGalleryButtons.length;
  const sourceButton = currentGalleryButtons[currentIndex];
  const image = sourceButton.querySelector('img');

  lightboxImage.src = sourceButton.dataset.lightboxSrc;
  lightboxImage.alt = image.alt;
  lightboxTitle.textContent = sourceButton.dataset.lightboxTitle;
  lightboxCount.textContent = `${String(currentIndex + 1).padStart(2, '0')} / ${String(currentGalleryButtons.length).padStart(2, '0')}`;
}

lightboxButtons.forEach((button) => {
  button.addEventListener('click', () => {
    currentGalleryButtons = [...button.closest('.media-grid').querySelectorAll('[data-lightbox-src]')];
    showImage(currentGalleryButtons.indexOf(button));
    lightbox.showModal();
  });
});

previousButton.addEventListener('click', () => showImage(currentIndex - 1));
nextButton.addEventListener('click', () => showImage(currentIndex + 1));
lightbox.querySelector('.lightbox-close').addEventListener('click', () => lightbox.close());

lightbox.addEventListener('click', (event) => {
  if (event.target === lightbox) lightbox.close();
});

document.addEventListener('keydown', (event) => {
  if (!lightbox.open) return;
  if (event.key === 'ArrowLeft') showImage(currentIndex - 1);
  if (event.key === 'ArrowRight') showImage(currentIndex + 1);
});

const teamLinks = [...document.querySelectorAll('.team-nav a')];
const teamSections = teamLinks.map((link) => document.querySelector(link.hash));
let scrollFrame = 0;

function updateActiveTeam() {
  const currentSection = [...teamSections]
    .reverse()
    .find((section) => section.getBoundingClientRect().top <= 180) ?? teamSections[0];

  teamLinks.forEach((link) => {
    const active = link.hash === `#${currentSection.id}`;
    link.classList.toggle('is-active', active);
    if (active) link.setAttribute('aria-current', 'location');
    else link.removeAttribute('aria-current');
  });
}

window.addEventListener('scroll', () => {
  cancelAnimationFrame(scrollFrame);
  scrollFrame = requestAnimationFrame(updateActiveTeam);
}, { passive: true });

window.addEventListener('hashchange', updateActiveTeam);
updateActiveTeam();
