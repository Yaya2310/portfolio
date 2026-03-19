document.addEventListener('DOMContentLoaded', () => {
    
    // 1. Mobile Navigation Toggle
    const hamburger = document.querySelector('.hamburger');
    const navLinks = document.querySelector('.nav-links');
    const navItems = document.querySelectorAll('.nav-links a');
    
    // Toggle menu
    hamburger.addEventListener('click', () => {
        navLinks.classList.toggle('active');
        
        // Change icon
        const icon = hamburger.querySelector('i');
        if(navLinks.classList.contains('active')) {
            icon.classList.remove('fa-bars');
            icon.classList.add('fa-times');
        } else {
            icon.classList.remove('fa-times');
            icon.classList.add('fa-bars');
        }
    });

    // Mobile Dropdown toggles
    const dropdowns = document.querySelectorAll('.dropdown');
    const nestedDropdowns = document.querySelectorAll('.nested-dropdown');

    dropdowns.forEach(dropdown => {
        const link = dropdown.querySelector('a');
        link.addEventListener('click', (e) => {
            if(window.innerWidth <= 768) {
                // If it's just meant to open the menu, prevent default
                // To allow going to the page on second tap, we can leave default
                if(!dropdown.classList.contains('active')) {
                    e.preventDefault();
                    
                    // Close other dropdowns
                    dropdowns.forEach(d => { if(d !== dropdown) d.classList.remove('active'); });
                    dropdown.classList.add('active');
                }
            }
        });
    });

    nestedDropdowns.forEach(nested => {
        const link = nested.querySelector('a');
        link.addEventListener('click', (e) => {
            if(window.innerWidth <= 768) {
                if(!nested.classList.contains('active')) {
                    e.preventDefault();
                    
                    nestedDropdowns.forEach(n => { if(n !== nested) n.classList.remove('active'); });
                    nested.classList.add('active');
                }
            }
        });
    });

    // 2. Navbar Background on Scroll
    const navbar = document.querySelector('.navbar');
    
    window.addEventListener('scroll', () => {
        if (window.scrollY > 50) {
            navbar.classList.add('scrolled');
        } else {
            navbar.classList.remove('scrolled');
        }
        
        // Active link highlighting
        highlightNavOnScroll();
    });

    // Update active nav link based on scroll position
    const sections = document.querySelectorAll('section');
    
    function highlightNavOnScroll() {
        let current = '';
        const scrollY = window.scrollY;
        
        sections.forEach(section => {
            const sectionTop = section.offsetTop - 100;
            const sectionHeight = section.clientHeight;
            if (scrollY >= sectionTop && scrollY < sectionTop + sectionHeight) {
                current = section.getAttribute('id');
            }
        });

        navItems.forEach(a => {
            a.classList.remove('active');
            // Check if current matches href
            if (a.getAttribute('href') === `#${current}`) {
                a.classList.add('active');
            }
        });
    }

    // 3. Number Counter Animation for Stats
    const counters = document.querySelectorAll('.counter');
    const statsSection = document.querySelector('.presentation-stats');
    let started = false; // to trigger animation only once

    function startCounters() {
        counters.forEach(counter => {
            const updateCount = () => {
                const target = +counter.getAttribute('data-target');
                const count = +counter.innerText;
                const speed = 200; // Lower is faster
                const inc = target / speed;

                if (count < target) {
                    counter.innerText = Math.ceil(count + inc);
                    setTimeout(updateCount, 10);
                } else {
                    counter.innerText = target;
                    // Add '+' sign if it's the original target
                    if(target == 10 || target >= 170) {
                        counter.innerText = target + '+';
                    }
                }
            };
            updateCount();
        });
    }

    // Use Intersection Observer for stats
    if (statsSection) {
        const statsObserver = new IntersectionObserver((entries) => {
            entries.forEach(entry => {
                if (entry.isIntersecting && !started) {
                    startCounters();
                    started = true;
                }
            });
        }, { threshold: 0.5 });
        
        statsObserver.observe(statsSection);
    }

    // 4. Scroll Reveal Animations
    const animatedElements = document.querySelectorAll('.fade-in, .fade-in-up, .slide-in-left, .slide-in-right');
    
    const revealObserver = new IntersectionObserver((entries, observer) => {
        entries.forEach(entry => {
            if (entry.isIntersecting) {
                entry.target.classList.add('visible');
                observer.unobserve(entry.target); // Optional: stop observing once revealed
            }
        });
    }, {
        threshold: 0.15, // Trigger when 15% visible
        rootMargin: "0px 0px -50px 0px" // Trigger slightly before it comes into view
    });

    animatedElements.forEach(el => {
        revealObserver.observe(el);
    });

    // 5. Update Footer Year
    const yearSpan = document.getElementById('year');
    if(yearSpan) {
        yearSpan.textContent = new Date().getFullYear();
    }
});
