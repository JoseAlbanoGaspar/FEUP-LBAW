function addUserSearchEventListeners() {
    let usersSearchBar = document.querySelector('#users-search-bar');
    if (usersSearchBar != null) {
        usersSearchBar.nextElementSibling.addEventListener('click', searchUsersHandler);
    }
    if (window.location.pathname.includes('/search_users')) {
        let nextButton = document.querySelector('a[rel="next"]');
        if (nextButton != null) {
            nextButton.setAttribute('href', '#');
            nextButton.addEventListener('click', nextButtonEventHandler);
        }
        let prevButton = document.querySelector('a[rel="prev"]');
        if (prevButton != null) {
            prevButton.setAttribute('href', '#');
            prevButton.addEventListener('click', prevButtonEventHandler);
        }
    }
}

function selectSearchOptionsFromPath(url) {
    let filters = url.searchParams.get("filters");
    let order = url.searchParams.get("order");
    let sort = url.searchParams.get("sort");

    if (filters === "all") {
        document.getElementById("search-filter-all").classList.add("active");
    } else if (filters === "questions") {
        document.getElementById("search-filter-questions").classList.add("active");
    } else if (filters === "answers") {
        document.getElementById("search-filter-answers").classList.add("active");
    }

    if (order === "ascending") {
        document.getElementById("search-order-ascending").classList.add("active");
    } else if (order === "descending") {
        document.getElementById("search-order-descending").classList.add("active");
    }

    if (sort === "date") {
        document.getElementById("search-sort-date").classList.add("active");
    } else if (sort === "score") {
        document.getElementById("search-sort-score").classList.add("active");
    }
}

function addEventListeners() {
    let itemCheckers = document.querySelectorAll('article.card li.item input[type=checkbox]');
    [].forEach.call(itemCheckers, function (checker) {
        checker.addEventListener('change', sendItemUpdateRequest);
    });
    addUserSearchEventListeners();

    if (window.location.pathname.includes("search")) {
        let url = new URL(window.location.href);
        selectSearchOptionsFromPath(url);

        let filterAnchors = document.querySelectorAll('.search-filter');
        let sortAnchors = document.querySelectorAll('.search-sort');
        let orderAnchors = document.querySelectorAll('.search-order');

        if(filterAnchors != null) {filterAnchors.forEach(optionsButtonsHandler(filterAnchors));}
        if(orderAnchors != null){orderAnchors.forEach(optionsButtonsHandler(orderAnchors));}
        if(sortAnchors != null){sortAnchors.forEach(optionsButtonsHandler(sortAnchors));}
        addApplySearchOptionEventListener();
    }

}

function encodeForAjax(data) {
    if (data == null) return null;
    return Object.keys(data).map(function (k) {
        return encodeURIComponent(k) + '=' + encodeURIComponent(data[k])
    }).join('&');
}

function sendAjaxRequest(method, url, data, handler) {
    let request = new XMLHttpRequest();

    request.open(method, url, true);
    request.setRequestHeader('X-CSRF-TOKEN', document.querySelector('meta[name="csrf-token"]').content);
    request.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
    request.addEventListener('load', handler);
    request.send(encodeForAjax(data));
}

function sendItemUpdateRequest() {
    let item = this.closest('li.item');
    let id = item.getAttribute('data-id');
    let checked = item.querySelector('input[type=checkbox]').checked;

    sendAjaxRequest('post', '/api/item/' + id, {done: checked}, itemUpdatedHandler);
}

function sendDeleteItemRequest() {
    let id = this.closest('li.item').getAttribute('data-id');

    sendAjaxRequest('delete', '/api/item/' + id, null, itemDeletedHandler);
}

function sendCreateItemRequest(event) {
    let id = this.closest('article').getAttribute('data-id');
    let description = this.querySelector('input[name=description]').value;

    if (description != '')
        sendAjaxRequest('put', '/api/cards/' + id, {description: description}, itemAddedHandler);

    event.preventDefault();
}

function sendDeleteCardRequest(event) {
    let id = this.closest('article').getAttribute('data-id');

    sendAjaxRequest('delete', '/api/cards/' + id, null, cardDeletedHandler);
}

function sendCreateCardRequest(event) {
    let name = this.querySelector('input[name=name]').value;

    if (name != '')
        sendAjaxRequest('put', '/api/cards/', {name: name}, cardAddedHandler);

    event.preventDefault();
}

function itemUpdatedHandler() {
    let item = JSON.parse(this.responseText);
    let element = document.querySelector('li.item[data-id="' + item.id + '"]');
    let input = element.querySelector('input[type=checkbox]');
    element.checked = item.done == "true";
}

function itemAddedHandler() {
    if (this.status != 200) window.location = '/';
    let item = JSON.parse(this.responseText);

    // Create the new item
    let new_item = createItem(item);

    // Insert the new item
    let card = document.querySelector('article.card[data-id="' + item.card_id + '"]');
    let form = card.querySelector('form.new_item');
    form.previousElementSibling.append(new_item);

    // Reset the new item form
    form.querySelector('[type=text]').value = "";
}

function itemDeletedHandler() {
    if (this.status != 200) window.location = '/';
    let item = JSON.parse(this.responseText);
    let element = document.querySelector('li.item[data-id="' + item.id + '"]');
    element.remove();
}

function cardDeletedHandler() {
    if (this.status != 200) window.location = '/';
    let card = JSON.parse(this.responseText);
    let article = document.querySelector('article.card[data-id="' + card.id + '"]');
    article.remove();
}

function cardAddedHandler() {
    if (this.status != 200) window.location = '/';
    let card = JSON.parse(this.responseText);

    // Create the new card
    let new_card = createCard(card);

    // Reset the new card input
    let form = document.querySelector('article.card form.new_card');
    form.querySelector('[type=text]').value = "";

    // Insert the new card
    let article = form.parentElement;
    let section = article.parentElement;
    section.insertBefore(new_card, article);

    // Focus on adding an item to the new card
    new_card.querySelector('[type=text]').focus();
}

function createCard(card) {
    let new_card = document.createElement('article');
    new_card.classList.add('card');
    new_card.setAttribute('data-id', card.id);
    new_card.innerHTML = `

  <header>
    <h2><a href="cards/${card.id}">${card.name}</a></h2>
    <a href="#" class="delete">&#10761;</a>
  </header>
  <ul></ul>
  <form class="new_item">
    <input name="description" type="text">
  </form>`;

    let creator = new_card.querySelector('form.new_item');
    creator.addEventListener('submit', sendCreateItemRequest);

    let deleter = new_card.querySelector('header a.delete');
    deleter.addEventListener('click', sendDeleteCardRequest);

    return new_card;
}

function createItem(item) {
    let new_item = document.createElement('li');
    new_item.classList.add('item');
    new_item.setAttribute('data-id', item.id);
    new_item.innerHTML = `
  <label>
    <input type="checkbox"> <span>${item.description}</span><a href="#" class="delete">&#10761;</a>
  </label>
  `;

    new_item.querySelector('input').addEventListener('change', sendItemUpdateRequest);
    new_item.querySelector('a.delete').addEventListener('click', sendDeleteItemRequest);

    return new_item;
}

function searchUsersHandler(event) {
    event.preventDefault();
    let usersSearchBar = document.querySelector('#users-search-bar');

    let url = new URL(window.location.href);
    let page = url.searchParams.get("page");


    if (page == null) {
        page = 1;
    }
    url.searchParams.delete("page");
    window.history.replaceState({}, document.title, "/search_users?query=" + usersSearchBar.firstElementChild.value);
    let query = usersSearchBar.firstElementChild.value;

    sendAjaxRequest('POST', '/api/search_users', {
        query: usersSearchBar.firstElementChild.value,
        page: page
    }, async function () {

       userSearchResponseHandler(query, page);
       document.querySelector('#users-search-bar').firstElementChild.focus();
    });
}

function prevButtonEventHandler(event) {
    searchUsersPageButtonsHandler(event, false);
}

function userSearchResponseHandler(query, page) {
    sendAjaxRequest('POST', '/api/search_users', {query: query, page: page}, async function () {
        let originalContent = document.querySelector('#content');
        let response = JSON.parse(this.responseText);
        console.log(this.responseText);
        let parser = new DOMParser();
        const doc = parser.parseFromString(response.html, 'text/html');
        let newContent = doc.querySelector('#content');
        originalContent.innerHTML = newContent.innerHTML;
        document.querySelector('#users-search-bar').firstElementChild.value = query;
        addUserSearchEventListeners();
    });
}

function searchUsersPageButtonsHandler(event, next) {
    let url = new URL(window.location.href);
    let query = url.searchParams.get("query");
    let page = url.searchParams.get("page");
    if (page == null) {
        page = 1;
    }
    event.preventDefault();
    if (next) {
        page++;
    } else {
        page--;
    }
    url.searchParams.set("page", page);
    window.history.replaceState({}, document.title, url.href);

    userSearchResponseHandler(query, page);
}

function nextButtonEventHandler(event) {
    searchUsersPageButtonsHandler(event, true);
}

function highlightSidenav(){
    if (window.location.pathname.includes("users")) {
        document.getElementById("users-sidenav").classList.replace("link-dark","selected");
    }else if (window.location.pathname.includes("questions")){
        document.getElementById("questions-sidenav").classList.replace("link-dark","selected");
    }else if (window.location.pathname.includes("home")){
        document.getElementById("homepage-sidenav").classList.replace("link-dark","selected");
    }else if (window.location.pathname.includes("personal_feed")){
        document.getElementById("personalfeed-sidenav").classList.replace("link-dark","selected");
    }
}


function createRemoveOptionsButton(applyButton) {
    let removeOptionsButton = document.createElement("button");
    removeOptionsButton.classList.add("btn", "btn-danger");
    removeOptionsButton.id = "remove-options-button";
    removeOptionsButton.innerText = "Remove Options";
    document.querySelector("#dropdown-order").after(removeOptionsButton);
    removeOptionsButton.addEventListener("click", function (event) {
        let anchors = document.querySelectorAll(".dropdown a");
        anchors.forEach(anchor => {
            anchor.classList.remove("active");
        });
        removeOptionsButton.remove();
        applyButton.remove();
    });
}

function filterButtonsHandler(anchors) {

    return anchor => {
        anchor.addEventListener("click", function (event) {
            let applyButton = document.querySelector("#apply-search-button");
            if(applyButton == null){
                applyButton = document.createElement("button");
                applyButton.classList.add("btn", "btn-primary");
                applyButton.id = "apply-search-button";
                applyButton.innerText = "Apply";
                document.querySelector("#dropdown-order").after(applyButton);
                createRemoveOptionsButton(applyButton);
            }
            event.preventDefault();

            anchors.forEach(anchor => {
                anchor.classList.remove("active");
            });
            anchor.classList.add("active");
            addApplySearchOptionEventListener();
        });
    };
}
function orderButtonsHandler(anchors) {

    return anchor => {
        anchor.addEventListener("click", function (event) {
            let applyButton = document.querySelector("#apply-search-button");
            if(applyButton == null){
                applyButton = document.createElement("button");

                applyButton.classList.add("btn", "btn-primary");
                applyButton.id = "apply-search-button";
                applyButton.innerText = "Apply";
                document.querySelector("#dropdown-order").after(applyButton);
                createRemoveOptionsButton(applyButton);
            }
            event.preventDefault();

            anchors.forEach(anchor => {
                anchor.classList.remove("active");
            });
            anchor.classList.add("active");
            addApplySearchOptionEventListener();
        });
    };
}
function sortButtonsHandler(anchors) {

    return anchor => {
        anchor.addEventListener("click", function (event) {
            let applyButton = document.querySelector("#apply-search-button");
            if(applyButton == null){
                applyButton = document.createElement("button");

                applyButton.classList.add("btn", "btn-primary");
                applyButton.id = "apply-search-button";
                applyButton.innerText = "Apply";
                document.querySelector("#dropdown-order").after(applyButton);
                createRemoveOptionsButton(applyButton);
            }
            event.preventDefault();

            anchors.forEach(anchor => {
                anchor.classList.remove("active");
            });
            anchor.classList.add("active");

            addApplySearchOptionEventListener();
        });
    };
}
function optionsButtonsHandler(anchors) {

    return anchor => {
        anchor.addEventListener("click", function (event) {
            let applyButton = document.querySelector("#apply-search-button");
            if(applyButton == null){
                applyButton = document.createElement("button");

                applyButton.classList.add("btn", "btn-primary");
                applyButton.id = "apply-search-button";
                applyButton.innerText = "Apply";
                document.querySelector("#dropdown-order").after(applyButton);
                createRemoveOptionsButton(applyButton);
            }
            event.preventDefault();

            anchors.forEach(anchor => {
                anchor.classList.remove("active");
            });
            anchor.classList.add("active");

            addApplySearchOptionEventListener();
        });
    };
}

function addApplySearchOptionEventListener() {
    let applyButton = document.querySelector("#apply-search-button");
    if (applyButton != null) {
        applyButton.addEventListener("click", function (event) {
            let filterElement = document.querySelector(".search-filter.active");
            let orderElement = document.querySelector(".search-order.active");
            let sortElement = document.querySelector(".search-sort.active");

            let filters, order, sort;
            if(filterElement != null){
                filters = filterElement.id.split("-")[2];
            }
            if(orderElement != null){
                order = orderElement.id.split("-")[2];
            }
            if(sortElement != null){
                sort = sortElement.id.split("-")[2];
            }

            event.preventDefault();
            let url = new URL(window.location.href);
            if (filters != null) {
                url.searchParams.set("filters", filters);
            }
            else{
                url.searchParams.delete("filters");
            }
            if (order != null) {
                url.searchParams.set("order", order);
            }
            else{
                url.searchParams.delete("order");
            }
            if (sort != null) {
                url.searchParams.set("sort", sort);
            }
            else{
                url.searchParams.delete("sort");
            }
            window.location.replace(url);
        });
    }
}

function adminMode(){
    let adminButtons = document.querySelectorAll('.admin');
    for(let button of adminButtons){
        button.classList.toggle('notadmin');
    }

}

function editAnswer(id,pgid){
    let csfr =  document.querySelector('meta[name="csrf-token"]').content;
    
    
    let classname = '.pedit-' + id;
    
    let p = document.querySelector(classname);
    let text = p.textContent;
    let form = document.createElement('div');
    form.innerHTML = 
    "<form method='POST' action='/../posts/edit'><input type='hidden' name='_token' value='" + csfr+ "'><input value=" + pgid + " name='id_question' type='hidden'/><input value=" + id + " name='id_post' type='hidden'/><textarea id='text-area' name='text_body'>" + text + "</textarea><button id='edit-post-button' type='submit'>Edit</button></form><a role='button' class='btn btn-secondary btn-sm mx-2 text-center' href='" + pgid + "'>Cancel</a>";
    console.log(form);
    p.parentNode.insertBefore(form,p);
    let edit = p.nextElementSibling.firstElementChild.nextElementSibling;
    let deleted = edit.nextElementSibling;
    console.log(edit);
    console.log(deleted);
    edit.parentNode.removeChild(edit);
    deleted.parentNode.removeChild(deleted);
    p.parentNode.removeChild(p);

    /*let editPostButton = document.querySelector('#edit-post-button');
    if(editPostButton != null){
        editPostButton.addEventListener('click', routeEditPost);
    }*/
}

function routeEditPost(event){
    event.preventDefault();
    let textarea = document.querySelector('#text-area');
    let textvalue = textarea.textContent;
    let id = textarea.previousElementSibling.getAttribute('value');
    
    sendAjaxRequest('PATCH','/../posts/edit',{text_body : textvalue, id_post: id},async function () {
        let originalContent = document.querySelector('#content');
        let response = JSON.parse(this.responseText);
        console.log(this.responseText);});
}

highlightSidenav();
addEventListeners();
