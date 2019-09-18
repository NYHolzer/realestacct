
function buildingButtonClick() {
    document.querySelector('.buildings').addEventListener("click", function(e){
        e.preventDefault
        requestBuildings()
    })
}

function requestBuildings(){
    fetch('http://localhost:3000/buildings.json')
        .then((resp) => resp.json())
        .then((data) => console.log(data))
}