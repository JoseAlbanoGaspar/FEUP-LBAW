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

function addEventListeners() {
    let itemCheckers = document.querySelectorAll('article.card li.item input[type=checkbox]');
    [].forEach.call(itemCheckers, function (checker) {
        checker.addEventListener('change', sendItemUpdateRequest);
    });

    let itemCreators = document.querySelectorAll('article.card form.new_item');
    [].forEach.call(itemCreators, function (creator) {
        creator.addEventListener('submit', sendCreateItemRequest);
    });

    let itemDeleters = document.querySelectorAll('article.card li a.delete');
    [].forEach.call(itemDeleters, function (deleter) {
        deleter.addEventListener('click', sendDeleteItemRequest);
    });

    let cardDeleters = document.querySelectorAll('article.card header a.delete');
    [].forEach.call(cardDeleters, function (deleter) {
        deleter.addEventListener('click', sendDeleteCardRequest);
    });

    let cardCreator = document.querySelector('article.card form.new_card');
    if (cardCreator != null)
        cardCreator.addEventListener('submit', sendCreateCardRequest);

    addUserSearchEventListeners();

    if (window.location.pathname.includes("search")) {
        let url = new URL(window.location.href);
        let filters = url.searchParams.get("filters");
        let order = url.searchParams.get("order");
        let sort = url.searchParams.get("sort");

        let filterAnchors = document.querySelectorAll('.search-filter');
        let sortAnchors = document.querySelectorAll('.search-sort');
        let orderAnchors = document.querySelectorAll('.search-order');


        if(filterAnchors != null) {filterAnchors.forEach(filterButtonsHandler(filterAnchors, filters));}
        if(orderAnchors != null){orderAnchors.forEach(orderButtonsHandler(orderAnchors, order));}
        if(sortAnchors != null){sortAnchors.forEach(sortButtonsHandler(sortAnchors, sort));}
        addApplySearchOptionEventListener(filters, order, sort);
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
    // captureEvents()
    // console.log(event);
    event.preventDefault();
    // wait 1 second after typin
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


function filterButtonsHandler(anchors, filters) {

    return anchor => {
        anchor.addEventListener("click", function (event) {
            let applyButton = document.querySelector("#apply-search-button");
            if(applyButton == null){
                applyButton = document.createElement("button");
                applyButton.classList.add("btn", "btn-primary");
                applyButton.id = "apply-search-button";
                applyButton.innerText = "Apply";
                document.querySelector("#dropdown-order").after(applyButton);
            }
            event.preventDefault();

            if(anchor.id === "search-filter-all"){
                filters = "all";
            }
            else if(anchor.id === "search-filter-answers"){
                filters = "answers";
            }
            else if(anchor.id === "search-filter-questions"){
                filters = "questions";
            }

            anchors.forEach(anchor => {
                anchor.classList.remove("active");
            });
            anchor.classList.add("active");
            addApplySearchOptionEventListener(filters, null, null);
        });
    };
}
function orderButtonsHandler(anchors, order) {

    return anchor => {
        anchor.addEventListener("click", function (event) {
            let applyButton = document.querySelector("#apply-search-button");
            if(applyButton == null){
                applyButton = document.createElement("button");
                applyButton.classList.add("btn", "btn-primary");
                applyButton.id = "apply-search-button";
                applyButton.innerText = "Apply";
                document.querySelector("#dropdown-order").after(applyButton);
            }
            event.preventDefault();

            if(anchor.id === "search-order-ascending"){
                order = "ascending";
            }
            else if(anchor.id === "search-order-descending"){
                order = "descending";
            }

            anchors.forEach(anchor => {
                anchor.classList.remove("active");
            });
            anchor.classList.add("active");
            addApplySearchOptionEventListener(null, order, null);
        });
    };
}
function sortButtonsHandler(anchors, sort) {

    return anchor => {
        anchor.addEventListener("click", function (event) {
            let applyButton = document.querySelector("#apply-search-button");
            if(applyButton == null){
                applyButton = document.createElement("button");
                applyButton.classList.add("btn", "btn-primary");
                applyButton.id = "apply-search-button";
                applyButton.innerText = "Apply";
                document.querySelector("#dropdown-order").after(applyButton);
            }
            event.preventDefault();

            if(anchor.id === "search-sort-score"){
                sort = "score";
            }
            else if(anchor.id === "search-sort-date"){
                sort = "date";
            }

            anchors.forEach(anchor => {
                anchor.classList.remove("active");
            });
            anchor.classList.add("active");
            addApplySearchOptionEventListener(null, null, sort);
        });
    };
}

function addApplySearchOptionEventListener(filters, order, sort) {
    let applyButton = document.querySelector("#apply-search-button");
    if (applyButton != null) {
        applyButton.addEventListener("click", function (event) {
            event.preventDefault();
            let url = new URL(window.location.href);
            if (filters != null) {
                url.searchParams.set("filters", filters);
            }
            if (order != null) {
                url.searchParams.set("order", order);
            }
            if (sort != null) {
                url.searchParams.set("sort", sort);
            }
            window.location.replace(url);
        });
    }
}

function editAnswer(id, text){
							
    edit_field = document.createElement("div");
    edit_field.innerHTML = `				
    <form method="PATCH" action="posts/edit" enctype="multipart/form-data">
        <input type="hidden" value="${id}" name="id_post">
        <textarea class="form-control" name="text_body" aria-label="Edit answer" rows="8">${text}</textarea>
        <button id="submit-button" class="btn btn-secondary btn-sm mx-2 text-center" type="submit">
            Post Your Answer </button>
        <button class="btn btn-secondary btn-sm mx-2 text-center">
            Discard
        </button>
    </form>`;
    toBeDeleted = document.getElementById(`answer-content-${id}`);
    document.body.insertBefore(edit_field, toBeDeleted);
    toBeDeleted.remove();
    document.getElementById(`editButton-${id}`).innerHTML = `Submit`;
    
}

highlightSidenav();
addEventListeners();
