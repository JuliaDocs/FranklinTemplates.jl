function toggleBookContent(src) {
    var buttonId = src.parentNode.parentNode.id;
    const normalCard = document.querySelector(`#${buttonId} .normal-card`);
    const reviewCard = document.querySelector(`#${buttonId} .review-card`);

    reviewCard.style.height = `${normalCard.offsetHeight}px`;

    if (src.textContent === "My Review") {
        src.textContent = "Back";
    } else {
        src.textContent = "My Review";
    }
    
    reviewCard.classList.toggle('visible');
    normalCard.classList.toggle('hidden');
}

function togglePublicationContent(src) {
    var buttonId = src.parentNode.parentNode.id;
    const normalCard = document.querySelector(`#${buttonId} .normal-card`);
    const reviewCard = document.querySelector(`#${buttonId} .review-card`);

    reviewCard.style.height = `${normalCard.offsetHeight}px`;

    if (src.textContent === "Abstract") {
        src.textContent = "Details";
    } else {
        src.textContent = "Abstract";
    }
    
    reviewCard.classList.toggle('visible');
    normalCard.classList.toggle('hidden');
}