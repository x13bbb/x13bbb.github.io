let lastStarTime = 0;
const starInterval = 100; // Minimum time between stars in milliseconds

function createStar() {
  const star = document.createElementNS("http://www.w3.org/2000/svg", "svg");
  star.setAttribute("viewBox", "0 0 24 24");
  star.setAttribute("width", "40"); // Increased from 20 to 40
  star.setAttribute("height", "40"); // Increased from 20 to 40
  star.classList.add("star");

  const path = document.createElementNS("http://www.w3.org/2000/svg", "path");
  path.setAttribute("d", "M12 .587l3.668 7.568 8.332 1.151-6.064 5.828 1.48 8.279-7.416-3.967-7.417 3.967 1.481-8.279-6.064-5.828 8.332-1.151z");
  path.setAttribute("fill", "#f0e7d5");

  star.appendChild(path);
  return star;
}

document.addEventListener("mousemove", function(event) {
  const currentTime = Date.now();
  if (currentTime - lastStarTime > starInterval) {
    const star = createStar();
    star.style.left = (event.clientX - 20) + "px"; // Adjusted for new size
    star.style.top = (event.clientY - 20) + "px"; // Adjusted for new size
    
    document.getElementById("star-trail").appendChild(star);
    
    setTimeout(function() {
      star.remove();
    }, 1200); // Increased to match new animation duration

    lastStarTime = currentTime;
  }
});