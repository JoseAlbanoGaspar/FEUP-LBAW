function addUserSearchEventListeners() {
    let usersSearchBar = document.querySelector('#users-search-bar');
    if (usersSearchBar != null) {
        usersSearchBar.nextElementSibling.addEventListener('click', searchUsersHandler);
        usersSearchBar.firstElementChild.addEventListener('keypress', searchUsersHandler);
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

    if (filters != null || order != null || sort != null) {
        createApplyNoOptions();
    }

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
    } else if (sort === "answercount") {
        document.getElementById("search-sort-answercount").classList.add("active");
    }

}

function addEventListeners() {
    addUserSearchEventListeners();

    if (window.location.pathname.includes("search") && !window.location.pathname.includes("search_")) {
        let url = new URL(window.location.href);
        selectSearchOptionsFromPath(url);

        let filterAnchors = document.querySelectorAll('.search-filter');
        let sortAnchors = document.querySelectorAll('.search-sort');
        let orderAnchors = document.querySelectorAll('.search-order');

        if (filterAnchors != null) {
            filterAnchors.forEach(optionsButtonsHandler(filterAnchors));
        }
        if (orderAnchors != null) {
            orderAnchors.forEach(optionsButtonsHandler(orderAnchors));
        }
        if (sortAnchors != null) {
            sortAnchors.forEach(optionsButtonsHandler(sortAnchors));
        }
        addApplySearchOptionEventListener();
    }
    if (window.location.pathname.includes("questions") && !window.location.pathname.includes("questions/")) {
        let url = new URL(window.location.href);
        selectSearchOptionsFromPath(url);

        let sortAnchors = document.querySelectorAll('.search-sort');
        let orderAnchors = document.querySelectorAll('.search-order');

        if (orderAnchors != null) {
            orderAnchors.forEach(optionsButtonsHandler(orderAnchors));
        }
        if (sortAnchors != null) {
            sortAnchors.forEach(optionsButtonsHandler(sortAnchors));
        }
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

function prevButtonEventHandler(event) {
    searchUsersPageButtonsHandler(event, false);
}

function nextButtonEventHandler(event) {
    searchUsersPageButtonsHandler(event, true);
}

function searchUsersHandler(event) {
    if (event.type === 'keypress' && event.keyCode !== 13) {
        return;
    }
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

function userSearchResponseHandler(query, page) {
    sendAjaxRequest('POST', '/api/search_users', {query: query, page: page}, async function () {
        let originalContent = document.querySelector('#content');
        let response = JSON.parse(this.responseText);
        // console.log(this.responseText);
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

function highlightSidenav() {
    if (window.location.pathname.includes("users")) {
        document.getElementById("users-sidenav").classList.replace("link-dark", "selected");
    } else if (window.location.pathname.includes("questions")) {
        document.getElementById("questions-sidenav").classList.replace("link-dark", "selected");
    } else if (window.location.pathname.includes("home")) {
        document.getElementById("homepage-sidenav").classList.replace("link-dark", "selected");
    } else if (window.location.pathname.includes("personal_feed")) {
        document.getElementById("personalfeed-sidenav").classList.replace("link-dark", "selected");
    }
}

function createApplyNoOptions() {

    let applyNoOptionsButton = document.createElement("button");
    applyNoOptionsButton.classList.add("btn");
    applyNoOptionsButton.classList.add("btn-primary");
    applyNoOptionsButton.classList.add("btn-sm");
    applyNoOptionsButton.classList.add("btn-block");
    applyNoOptionsButton.classList.add("mt-2");
    applyNoOptionsButton.classList.add("mb-2");
    applyNoOptionsButton.classList.add("apply-no-options");
    applyNoOptionsButton.innerHTML = "Search again with default options";

    document.querySelector("#dropdown-order").after(applyNoOptionsButton);
    applyNoOptionsButton.addEventListener("click", function (event) {
        let url = new URL(window.location.href);
        url.searchParams.delete("filters");
        url.searchParams.delete("order");
        url.searchParams.delete("sort");
        window.location.replace(url);
    });
}

function createRemoveOptionsButton(applyButton) {
    let applyNoOptionsButton = document.querySelector(".apply-no-options");
    if (applyNoOptionsButton != null) {
        applyNoOptionsButton.remove();
    }

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

        createApplyNoOptions();


    });
}

function optionsButtonsHandler(anchors) {

    return anchor => {
        anchor.addEventListener("click", function (event) {
            event.preventDefault();
            let applyButton = document.querySelector("#apply-search-button");
            if (applyButton == null) {

                applyButton = document.createElement("button");
                applyButton.classList.add("btn", "btn-primary");
                applyButton.id = "apply-search-button";
                applyButton.innerText = "Apply";
                document.querySelector("#dropdown-order").after(applyButton);
                createRemoveOptionsButton(applyButton);
            }

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
            if (filterElement != null) {
                filters = filterElement.id.split("-")[2];
            }
            if (orderElement != null) {
                order = orderElement.id.split("-")[2];
            }
            if (sortElement != null) {
                sort = sortElement.id.split("-")[2];
            }

            event.preventDefault();
            let url = new URL(window.location.href);
            if (filters != null) {
                url.searchParams.set("filters", filters);
            } else {
                url.searchParams.delete("filters");
            }
            if (order != null) {
                url.searchParams.set("order", order);
            } else {
                url.searchParams.delete("order");
            }
            if (sort != null) {
                url.searchParams.set("sort", sort);
            } else {
                url.searchParams.delete("sort");
            }
            window.location.replace(url);
        });
    }

}

function adminMode() {
    let adminButtons = document.querySelectorAll('.admin');
    if (adminButtons) {
        for (let button of adminButtons) {
            button.classList.toggle('notadmin');
        }
    }
}

function editAnswer(id, pgid) {
    let csfr = document.querySelector('meta[name="csrf-token"]').content;
    let classname = '.pedit-' + id;
    let p = document.querySelector(classname);
    let text = p.textContent;
    let form = document.createElement('div');
    form.innerHTML =
        "<form method='POST' action='/../posts/edit'><input type='hidden' name='_token' value='" + csfr + "'><input value=" + pgid + " name='id_question' type='hidden'/><input value=" + id + " name='id_post' type='hidden'/><textarea id='text-area' name='text_body'>" + text + "</textarea><button class='edit-post-button' type='submit'>Edit</button></form><a role='button' class='btn btn-secondary btn-sm mx-2 text-center' href='" + pgid + "'>Cancel</a>";
    console.log(form);
    p.parentNode.insertBefore(form, p);
    let editButton = document.querySelector('#edit-answer-button-' + id);
    let deleted = editButton.nextElementSibling;
    console.log(deleted);
    console.log(editButton);
    editButton.remove();
    deleted.remove();
    p.remove();
}
function cancelReport(id,id_user){
    let form = document.querySelector(".go-back-" + id).parentNode;
    let p = document.querySelector(".button-" + id).parentNode;
    
    let initialButton = document.createElement('p');
    initialButton.setAttribute('role','button');
    initialButton.setAttribute('class',"button-" + id + " btn btn-secondary btn-sm mx-2 text-center");
    initialButton.setAttribute('onclick',"addReport(" + id + "," + id_user + ")");
    initialButton.textContent = "Report";
    
    p.parentNode.insertBefore(initialButton,p);
    p.remove();
    form.remove();
}

function addReport(id,id_user){
    let csfr = document.querySelector('meta[name="csrf-token"]').content;

    let idname = '.button-' + id;
    
    let button = document.querySelector(idname);
    let form = document.createElement('div');
    form.innerHTML =
        "<form class='go-back-" + id +"' method='POST' action='/../../report/add'><input type='hidden' name='_token' value='" + csfr + "'><input type='hidden' name='id_post' value='" + id + "'><input type='hidden' name='id_user' value='" + id_user + "'><input type='radio' name='reason' value='offensive' required><label>Offensive</label><input type='radio' name='reason' value='impContent' required><label>Improper Content</label><input type='radio' name='reason' value='Other' required><label>Other</label><button type='submit'>Report</button></form>";
    button.parentNode.insertBefore(form,button);
    let prev = document.createElement('div');
    prev.innerHTML = "<p role='button' class='button-" + id + "' onclick='cancelReport(" + id + ',' + id_user + ")'  class='btn btn-secondary btn-sm mx-2 text-center'>Cancel</p>";
    button.parentNode.insertBefore(prev,button);
    button.remove();
}
/*
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
function altEditAnswer(id, text){

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

 */
highlightSidenav();
addEventListeners();
