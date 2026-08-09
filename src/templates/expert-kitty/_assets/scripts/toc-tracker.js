window.addEventListener('DOMContentLoaded', () => {
  const headings = Array.from(document.querySelectorAll('.franklin-content h1, .franklin-content h2, .franklin-content h3, .franklin-content h4'));
  const tocLinks = document.querySelectorAll('.franklin-toc a');
  
  if (headings.length === 0 || tocLinks.length === 0) return;

  function highlightCurrentSectionOnLoad() {
    let activeHeading = headings[0];
    const triggerLine = 90;

    for (const heading of headings) {
      const box = heading.getBoundingClientRect();
      
      if (box.top <= triggerLine) {
        activeHeading = heading;
      } else {
        break;
      }
    }

    if (activeHeading) {
      const id = activeHeading.getAttribute('id');
      const targetLink = document.querySelector(`.franklin-toc a[href="#${id}"]`);
      tocLinks.forEach((link) => link.classList.remove('active'));
      if (targetLink) targetLink.classList.add('active');
    }
  }

  highlightCurrentSectionOnLoad();

  const options = {
    root: null,
    rootMargin: '-80px 0px -75% 0px', 
    threshold: 0
  };

  let lastScrollY = window.scrollY;

  const observer = new IntersectionObserver((entries) => {
    const isScrollingUp = window.scrollY < lastScrollY;
    lastScrollY = window.scrollY;

    entries.forEach((entry) => {
      const id = entry.target.getAttribute('id');
      if (!id) return;

      const currentLink = document.querySelector(`.franklin-toc a[href="#${id}"]`);
      if (!currentLink) return;

      if (entry.isIntersecting) {
        tocLinks.forEach((link) => link.classList.remove('active'));
        currentLink.classList.add('active');
      } 
      else if (!entry.isIntersecting && isScrollingUp) {
        const currentIndex = headings.indexOf(entry.target);
        if (currentIndex > 0) {
          const previousHeading = headings[currentIndex - 1];
          const prevId = previousHeading.getAttribute('id');
          const prevLink = document.querySelector(`.franklin-toc a[href="#${prevId}"]`);
          
          if (prevLink) {
            tocLinks.forEach((link) => link.classList.remove('active'));
            prevLink.classList.add('active');
          }
        }
      }
    });
  }, options);

  headings.forEach((heading) => observer.observe(heading));
});