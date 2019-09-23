function buildingButtonClick(){
    document.querySelector('.buildings').addEventListener("click", function(e){
        e.preventDefault
        requestBuildings()
    })
}  

function requestBuildings(){
    fetch('http://localhost:3000/buildings.json')
        .then((resp) => resp.json())
        .then((data) => {
            let buildingsData = data
            getBuildingsData(buildingsData)
            document.append('.main')
        })
}

function getBuildingsData(buildingsData) {
    buildingsData.forEach(function(building){
        new Building(building)}
    )  
}

class Building {
    constructor(obj) {
        this.id = obj.id
        this.name = obj.name
        this.address1 = obj.address1
        this.address2 = obj.address2
        this.city = obj.city
        this.state = obj.state 
        this.zip_code = obj.zip_code
        this.units = obj.units
    }
}

Building.prototype.postHTML = function() {
    
}