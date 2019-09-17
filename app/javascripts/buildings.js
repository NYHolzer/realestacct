// Want to start listening only after the page has loaded
$(function() {
    console.log('building.js is loaded...')
    listenForClick()
})

function listenForClick() {
    $('.building-name').on('click', function(event){
        event.preventDefault()
    } )
}