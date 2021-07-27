const circle = document.querySelector('.circle');
const triangle = document.querySelector('.triangle');

window.onload = setTimeout(() => {
    circle.classList.remove('bounceInUp')
    circle.classList.add('bounce');

    triangle.classList.remove('bounceInDown')
    triangle.classList.add('bounce');

    circle.style.animationIterationCount = 'infinite';
    triangle.style.animationIterationCount = 'infinite';
}, 10000)