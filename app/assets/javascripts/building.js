function buildingButtonClick(){
    document.querySelector('.buildings').addEventListener("click", function(e){
        e.preventDefault()
        requestBuildings()
    }, {once: true})
}  

function requestBuildings(){
    fetch('http://localhost:3000/buildings.json')
        .then((resp) => resp.json())
        .then((data) => {
            let buildingsData = data
            setBuildings(buildingsData)
        })
}

function setBuildings(buildingsData) {
    let mainArea = document.querySelector('div.main')
    let newMain = document.createElement('div')
    let buildingsList = document.createElement('ul')

    newMain.innerHTML = '<h1> Buildings </h1>'

    buildingsData.forEach(function(building){
        let b = new Building(building)
        buildingsList.innerHTML += `<li>
                                    <button id='${b.id}'>${b.name}</button>
                                    <table id='building-${b.id}'> </table>
                                    </li>`
    })  

    newMain.appendChild(buildingsList)
    
    newMain.innerHTML += `<button id="newUnitForm"> Add New Unit </button>` 

    mainArea.innerHTML = newMain.innerHTML
    buildingDetailButtonClick()
}

function buildingDetailButtonClick(){
    document.querySelectorAll('li button').forEach(function(buildingName){
        buildingName.addEventListener("click", function(e){
            e.preventDefault()
            requestSpecificBuilding(this.id)
        })
    })   
}

function requestSpecificBuilding(id){
    fetch(`http://localhost:3000/buildings/${id}.json`)
    .then((resp) => resp.json())
    .then((data) => {
        let buildingData = data
        addBuildingToDom(buildingData.id, buildingData.units)
    })
}

function addBuildingToDom(id, units){
    debugger
    let table = document.getElementById(`building-${id}`)
    let html = ''

    html += Building.buildingTableStyle()
    html += Building.buildingTableHeaders(id)

    units.forEach(function(unit){
        let u = new Unit(unit)
        html += u.postHTML()
    })

    table.innerHTML = html
}
 
function addNewUnitFormListener(){
    document.querySelector("#newUnitForm").addEventListener('click', function(){
        let areaToAddForm = document.querySelector('ul')
        areaToAddForm.parentNode.innerHTML += Unit.unitNewForm()
        addNewUnitListener()
    })
}

function addNewUnitListener(){
    document.getElementById("postUnitData").addEventListener('submit', function(e){
        e.preventDefault()
        postUnitData()
    } 
    );
}

function postUnitData(){
    let apt_num = document.getElementById("apt_num").value
    let tenant = document.getElementById("tenant").value
    let building_id = document.getElementById("building_id").value

    fetch('http://localhost:3000/units.json', {
        method: "POST",
        body: JSON.stringify({apt_num: apt_num, tenant: tenant, building_id: building_id}),
        headers: { 
            "Content-Type": 'application/json',
            "X-CSRF-Token": Rails.csrfToken()
        }
    }).then((res) => res.json()) 
    .then((data) => alert(data))
    .catch((error) => console.log('Error:', error));

}

function sortByTenant(id){
    console.log('All Systems Clear!')
    let b = Building.findById(id)
    let sortedUnits = b.units.sort(
        function compare(a, b){
            if (a.tenant < b.tenant) {
                return -1;
            }
            if (a.tenant > b.tenant){
                return 1;
            }
            return 0;
        }
    )
    addBuildingToDom(id, sortedUnits)
}

class Unit {
    constructor(obj){
        this.id = obj.id
        this.apt_num = obj.apt_num
        this.tenant = obj.tenant

        Unit.all.push(this)
    }

    static unitNewForm(listOfBuildingName){ 
        let buildingOptions = []
        let listOfLi = document.querySelectorAll('li')
        let listOfBuildings = []
        let listItem = ''
        let listId = ''
            for (let i = 0; i < listOfLi.length; i++){
                 listId = listOfLi[i].id
                 listItem = listOfLi[i].childNodes[0].innerText;
                 buildingOptions += `<option value=${listId}>${listItem}</option>`
            };

        return(
            `<form id="postUnitData">
                    <label>Name</label>
                    <input type="text" name="apt_num" id="apt_num">
                    <label>Tenant</lable>
                    <input type="text" name="tenant" id="tenant">
                    <select name="building_id" id="building_id">
                        ${buildingOptions}
                    </select>
                    <input type="submit" VALUE="Add">
            </form>`
        )
    }
}

Unit.all = []

Unit.prototype.postHTML = function(){
    return (
        `<tr>
            <td>${this.apt_num}</td>
            <td>${this.tenant} </td>
        </tr>`
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

        Building.all.push(this)
    }

    static findById(id){
        return Building.all.find(building => building.id == id)
    }

    static buildingTableHeaders(id){
        return(
        ` <tr>
                <th class="apt-num">Apartment Number </th>
                <th class="tenant" onclick="sortByTenant(${id})">Tenant</th>
        </tr>`
        )
        
    }

    static buildingTableStyle(){
        return (
            `<style>
                table {
                font-family: arial, sans-serif;
                border-collapse: collapse;
                width: 25%;
                }
                
                td, th {
                border: 1px solid #dddddd;
                text-align: left;
                padding: 8px;
                }
                
                tr:nth-child(even) {
                background-color: #dddddd;
                }
            </style>`
        )
    }

    

    static newBuildingForm(){
        return (
            `<strong> New Building Form </strong>
                <form id="postData"> 
                    <label for="building_name">Name</label>
                    <input type="text" name="building[name]" id="building_name" style="background-image: url(&quot;data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAABAAAAAQCAYAAAAf8/9hAAABHklEQVQ4EaVTO26DQBD1ohQWaS2lg9JybZ+AK7hNwx2oIoVf4UPQ0Lj1FdKktevIpel8AKNUkDcWMxpgSaIEaTVv3sx7uztiTdu2s/98DywOw3Dued4Who/M2aIx5lZV1aEsy0+qiwHELyi+Ytl0PQ69SxAxkWIA4RMRTdNsKE59juMcuZd6xIAFeZ6fGCdJ8kY4y7KAuTRNGd7jyEBXsdOPE3a0QGPsniOnnYMO67LgSQN9T41F2QGrQRRFCwyzoIF2qyBuKKbcOgPXdVeY9rMWgNsjf9ccYesJhk3f5dYT1HX9gR0LLQR30TnjkUEcx2uIuS4RnI+aj6sJR0AM8AaumPaM/rRehyWhXqbFAA9kh3/8/NvHxAYGAsZ/il8IalkCLBfNVAAAAABJRU5ErkJggg==&quot;); background-repeat: no-repeat; background-attachment: scroll; background-size: 16px 18px; background-position: 98% 50%; cursor: auto;">
                    <br>
                    <label for="building_address1">Address1</label>
                    <input type="text" name="building[address1]" id="building_address1">
                    <br>
                    <label for="building_address2">Address2</label>
                    <input type="text" name="building[address2]" id="building_address2">
                    <br>
                    <label for="building_city">City</label>
                    <input type="text" name="building[city]" id="building_city">
                    <br>
                    <label for="building_state">State</label>
                    <select name="building[state]" id="building_state">
                        <option value="AL">Alabama</option>
                        <option value="AK">Alaska</option>
                        <option value="AZ">Arizona</option>
                        <option value="AR">Arkansas</option>
                        <option value="CA">California</option>
                        <option value="CO">Colorado</option>
                        <option value="CT">Connecticut</option>
                        <option value="DE">Delaware</option>
                        <option value="DC">District of Columbia</option>
                        <option value="FL">Florida</option>
                        <option value="GA">Georgia</option>
                        <option value="HI">Hawaii</option>
                        <option value="ID">Idaho</option>
                        <option value="IL">Illinois</option>
                        <option value="IN">Indiana</option>
                        <option value="IA">Iowa</option>
                        <option value="KS">Kansas</option>
                        <option value="KY">Kentucky</option>
                        <option value="LA">Louisiana</option>
                        <option value="ME">Maine</option>
                        <option value="MD">Maryland</option>
                        <option value="MA">Massachusetts</option>
                        <option value="MI">Michigan</option>
                        <option value="MN">Minnesota</option>
                        <option value="MS">Mississippi</option>
                        <option value="MO">Missouri</option>
                        <option value="MT">Montana</option>
                        <option value="NE">Nebraska</option>
                        <option value="NV">Nevada</option>
                        <option value="NH">New Hampshire</option>
                        <option value="NJ">New Jersey</option>
                        <option value="NM">New Mexico</option>
                        <option value="NY">New York</option>
                        <option value="NC">North Carolina</option>
                        <option value="ND">North Dakota</option>
                        <option value="OH">Ohio</option>
                        <option value="OK">Oklahoma</option>
                        <option value="OR">Oregon</option>
                        <option value="PA">Pennsylvania</option>
                        <option value="PR">Puerto Rico</option>
                        <option value="RI">Rhode Island</option>
                        <option value="SC">South Carolina</option>
                        <option value="SD">South Dakota</option>
                        <option value="TN">Tennessee</option>
                        <option value="TX">Texas</option>
                        <option value="UT">Utah</option>
                        <option value="VT">Vermont</option>
                        <option value="VA">Virginia</option>
                        <option value="WA">Washington</option>
                        <option value="WV">West Virginia</option>
                        <option value="WI">Wisconsin</option>
                        <option value="WY">Wyoming</option></select>
                        <br>
                    <label for="building_zip_code">Zip code</label>
                    <input type="text" name="building[zip_code]" id="building_zip_code">
                    <br>
                    <input type="submit">
                </form>`
            )
    }
}

Building.all = []