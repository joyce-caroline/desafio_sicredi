function AddItemDay () {
    document.getElementById("items-list-day").innerHTML += '<li  class="items-list">Lorem ipsum dolor sit amet consectetur.</li>'
}

function RemoveItemDay () {
    let item = document.getElementById("items-list-day");
    console.log(item.lastChild)

    if(item.parentNode){
        item.lastChild.remove();
    }
}

function AddItemNight () {
    document.getElementById("items-list-night").innerHTML += '<li  class="items-list">Lorem ipsum dolor sit amet consectetur.</li>'
}

function RemoveItemNight () {
    let item = document.getElementById("items-list-night");
    console.log(item.lastChild)

    if(item.parentNode){
        item.lastChild.remove();
    }
}
