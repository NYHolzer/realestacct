// // Want to start listening only after the page has loaded
// $(function() {
//     console.log('building.js is loaded...')
//     listenForClick()
// })

function listenForClick() {
    document.querySelector('.test').addEventListener("click", function(e){
        console.log(this)
    })
}

// function listenForClick() {
//     $('.test').on('click', function(){
//         console.log("Test This is Working YAY!!")
//     })
// }