let darkmode = localStorage.getItem('darkmode')
const themeSwitch = document.getElementById('theme-switch')

const enableDarkmode = () => {
    document.documentElement.classList.add('darkmode')
    document.querySelector('.menu-nav ul').classList.add('darkmode')
    localStorage.setItem('darkmode', 'active')
}

const disableDarkmode = () => {
    document.documentElement.classList.remove('darkmode')
    document.querySelector('.menu-nav ul').classList.remove('darkmode')
    localStorage.setItem('darkmode', null)
}

if (darkmode === 'active') enableDarkmode()

themeSwitch.addEventListener('click', () => {
    darkmode = localStorage.getItem('darkmode')
    darkmode !== 'active' ? enableDarkmode() : disableDarkmode()
})