/**
 * NEXUS DIGITAL - INTERACTIVE LOGIC
 * Animations, Particles, and Interactions
 */

document.addEventListener('DOMContentLoaded', () => {
    initNavbar();
    initParticles();
    initScrollAnimations();
    initMobileMenu();
    initFlipCards();
});

/**
 * Sticky Navbar Logic
 */
function initNavbar() {
    const navbar = document.getElementById('navbar');
    window.addEventListener('scroll', () => {
        if (window.scrollY > 50) {
            navbar.classList.add('scrolled');
        } else {
            navbar.classList.remove('scrolled');
        }
    });
}

/**
 * Particle System (50 floating elements)
 */
function initParticles() {
    const container = document.getElementById('particles');
    if (!container) return;

    const particleCount = 50;
    for (let i = 0; i < particleCount; i++) {
        const particle = document.createElement('div');
        particle.className = 'particle';

        // Random position
        const x = Math.random() * 100;
        const y = Math.random() * 100;
        const size = Math.random() * 4 + 2;
        const delay = Math.random() * 10;
        const duration = 15 + Math.random() * 20;

        particle.style.left = `${x}%`;
        particle.style.top = `${y}%`;
        particle.style.width = `${size}px`;
        particle.style.height = `${size}px`;
        particle.style.animation = `float-particle ${duration}s infinite linear`;
        particle.style.animationDelay = `-${delay}s`;

        container.appendChild(particle);
    }
}

// Add particle animation to stylesheet dynamically
const styleArr = document.createElement('style');
styleArr.innerHTML = `
    @keyframes float-particle {
        0% { transform: translateY(0) translateX(0); opacity: 0; }
        10% { opacity: 0.3; }
        90% { opacity: 0.3; }
        100% { transform: translateY(-100vh) translateX(50px); opacity: 0; }
    }
`;
document.head.appendChild(styleArr);

/**
 * Intersection Observer for Reveal Animations
 */
function initScrollAnimations() {
    const observerOptions = {
        threshold: 0.15,
        rootMargin: '0px 0px -50px 0px'
    };

    const observer = new IntersectionObserver((entries) => {
        entries.forEach(entry => {
            if (entry.isIntersecting) {
                entry.target.classList.add('animate-in');
            }
        });
    }, observerOptions);

    const animateElements = document.querySelectorAll('.animate-on-scroll');
    animateElements.forEach(el => observer.observe(el));
}

/**
 * Mobile Menu Logic
 */
function initMobileMenu() {
    const toggle = document.getElementById('mobile-toggle');
    const navLinks = document.querySelector('.nav-links');

    if (toggle) {
        toggle.addEventListener('click', () => {
            navLinks.style.display = navLinks.style.display === 'flex' ? 'none' : 'flex';
            if (navLinks.style.display === 'flex') {
                navLinks.style.flexDirection = 'column';
                navLinks.style.position = 'absolute';
                navLinks.style.top = 'calc(100% + 12px)';
                navLinks.style.left = '20px';
                navLinks.style.right = '20px';
                navLinks.style.width = 'auto';
                navLinks.style.background = 'rgba(5, 8, 18, 0.96)';
                navLinks.style.padding = '24px';
                navLinks.style.backdropFilter = 'blur(20px)';
                navLinks.style.borderRadius = '18px';
            }
        });
    }

    // Close on link click
    const links = document.querySelectorAll('.nav-links a');
    links.forEach(link => {
        link.addEventListener('click', () => {
            if (window.innerWidth < 768) {
                navLinks.style.display = 'none';
            }
        });
    });
}

/**
 * Flip Cards on Tap (Mobile)
 */
function initFlipCards() {
    const cards = document.querySelectorAll('.service-card-flip');

    cards.forEach(card => {
        card.addEventListener('click', () => {
            // Check if it's mobile or touch device logic can be added here
            // Hover handles desktop, click handles mobile/all
            const inner = card.querySelector('.service-card-inner');
            if (inner.style.transform === 'rotateY(180deg)') {
                inner.style.transform = 'rotateY(0deg)';
            } else {
                inner.style.transform = 'rotateY(180deg)';
            }
        });
    });
}

// Smooth scroll for anchors
document.querySelectorAll('a[href^="#"]').forEach(anchor => {
    anchor.addEventListener('click', function (e) {
        e.preventDefault();
        const target = document.querySelector(this.getAttribute('href'));
        if (target) {
            window.scrollTo({
                top: target.offsetTop - 80,
                behavior: 'smooth'
            });
        }
    });
});
