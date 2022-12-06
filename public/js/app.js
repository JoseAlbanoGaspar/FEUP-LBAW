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

    let markAsReadButtons = document.querySelectorAll('.mark-as-read-notification');
    if (markAsReadButtons) {
        for (let button of markAsReadButtons) {
            button.addEventListener('click', function (event) {
                event.preventDefault();
                let idNotification = button.id.split('-')[4];
                sendAjaxRequest('POST', '/api/dismiss_notification', {id_user: loggedUser.id_user, id_notification: idNotification}, function () {
                    let response = JSON.parse(this.responseText);
                    if (response.success) {
                        button.remove();
                        let notificationAnchor = document.querySelector('#notification-anchor-' + idNotification);
                        notificationAnchor.classList.add('text-muted');
                        document.querySelector('#notification-header-id-' + idNotification).classList.remove('fw-bold');
                        document.querySelector('#notification-time-ago-id-' + idNotification).classList.remove('fw-bold');
                    } else {
                        alert(response.message);
                    }
                });
            });
        }
    }


    let markAllAsReadButton = document.querySelector('#mark-all-notifications-as-read');
    if (markAllAsReadButton) {
        markAllAsReadButton.addEventListener('click', function (event) {
            event.preventDefault();
            sendAjaxRequest('POST', '/api/dismiss_all_notifications', {id_user: loggedUser.id_user}, function () {
                let response = JSON.parse(this.responseText);
                if (response.success) {
                    let markAsReadButtons = document.querySelectorAll('.mark-as-read-notification');
                    for (let button of markAsReadButtons) {
                        button.remove();
                    }
                    let notificationAnchors = document.querySelectorAll('.notification-anchor');
                    for (let anchor of notificationAnchors) {
                        anchor.classList.add('text-muted');
                    }
                    let notificationHeaders = document.querySelectorAll('.notification-header');
                    for (let header of notificationHeaders) {
                        header.classList.remove('fw-bold');
                    }
                    let notificationTimeAgo = document.querySelectorAll('.notification-time-ago');
                    for (let timeAgo of notificationTimeAgo) {
                        timeAgo.classList.remove('fw-bold');
                    }
                } else {
                    alert(response.message);
                }
            });
        });
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

function closeModal(id){
    let  modal = new bootstrap.Modal(document.getElementById(id));
    console.log(modal);
    modal.hide();
}

function logResponse(){
    console.log(JSON.parse(this.responseText));
}

function addLoginRequiredModal() {
    let modal = document.createElement('div');
    modal.innerHTML = `
                    <div class="modal fade" id="loginRequiredModal" tabindex="-1" role="dialog" aria-labelledby="loginRequiredModalLabel" aria-hidden="true">
                    <div class="modal-dialog" role="document">
                        <div class="modal-content">
                            <div class="modal-header">
                                <h5 class="modal-title" id="loginRequiredModalLabel">Login Required</h5>
                                <button id="close-login-modal" type="button" class="close btn"  aria-label="Close">
                                    <span aria-hidden="true">&times;</span>
                                </button>
                            </div>
                            <div class="modal-body">
                                <p>You must be logged in to vote.</p>
                                <a href="/login" class="btn btn-primary">Login</a>
                            </div>
                        </div>
                    </div>
                </div>
                    `;
    let content = document.querySelector('#content');
    content.appendChild(modal);
}

if (window.location.href.match(/questions\/\d+/)) {
    user = loggedUser ?? null;
    colorVoteButtons();
    addLoginRequiredModal();
    let voteButtons = document.querySelectorAll('.vote-button');
    if (voteButtons) {
        for (let button of voteButtons) {
            button.addEventListener('click', function (event) {
                event.preventDefault();
                if (user == null) {
                    let modal = new bootstrap.Modal(document.getElementById('loginRequiredModal'));
                    document.getElementById("close-login-modal").addEventListener("click", function () {
                        modal.hide();
                    });
                    modal.show();

                } else {
                    let postId = button.getAttribute('id').split('-')[2];
                    let vote = button.classList.contains('upvote-button') ? 1 : -1;
                    let score = button.parentElement.querySelector('.post-score');

                    let upvoteButton = button.parentElement.querySelector('.upvote-button');
                    let downvoteButton = button.parentElement.querySelector('.downvote-button');
                    console.log(loggedUser.id_user, postId);
                    if (upvoteButton.classList.contains('btn-outline-success')) {
                        score.textContent = (parseInt(score.textContent) - 1).toString();
                        upvoteButton.classList.remove('btn-outline-success');
                        if (downvoteButton.classList.contains('btn-outline-danger')) {
                            downvoteButton.classList.remove('btn-outline-danger');
                        }
                        sendAjaxRequest('POST', '/api/users/vote', {id_user: loggedUser.id_user, id_post: postId, score: 0}, logResponse);
                    }
                    else if (downvoteButton.classList.contains('btn-outline-danger')) {
                        score.textContent = (parseInt(score.textContent) + 1).toString();
                        downvoteButton.classList.remove('btn-outline-danger');
                        if (upvoteButton.classList.contains('btn-outline-success')) {
                            upvoteButton.classList.remove('btn-outline-success');
                        }
                        sendAjaxRequest('POST', '/api/users/vote', {id_user: loggedUser.id_user, id_post: postId, score: 0}, logResponse);
                    }
                    else if (vote === 1) {
                        score.textContent = parseInt(score.textContent) + vote;
                        upvoteButton.classList.add('btn-outline-success');
                        sendAjaxRequest('POST', '/api/users/vote', {id_user: loggedUser.id_user, id_post: postId, score: 1}, logResponse);

                    }
                    else if (vote === -1) {
                        score.textContent = parseInt(score.textContent) + vote;
                        downvoteButton.classList.add('btn-outline-danger');
                        sendAjaxRequest('POST', '/api/users/vote', {id_user: loggedUser.id_user, id_post: postId, score: -1}, logResponse);
                    }
                }
            });
        }
    }
}

function colorVoteButtons() {
    if(!loggedUser) return;
    let questionId = document.querySelector('.question_header').id.split('_')[3];
    sendAjaxRequest('GET', '/api/users/'+ loggedUser.id_user + '/votes_on_question/' + questionId  , null, function () {
        let response = JSON.parse(this.responseText);
        let questionVote = response.questionVote[0];
        let answerVotes = response.answerVotes;
        let upvoteButton = document.querySelector('#upvote-button-' + questionId);
        let downvoteButton = document.querySelector('#downvote-button-' + questionId);
        if (questionVote != null) {
            if (questionVote.score === 1) {
                upvoteButton.classList.add('btn-outline-success');
            } else if (questionVote.score === -1) {
                downvoteButton.classList.add('btn-outline-danger');
            }
        }

        for (let answerVote of answerVotes) {
            let answerId = answerVote.id_answer;
            let upvoteButton = document.querySelector('#upvote-button-' + answerId);
            let downvoteButton = document.querySelector('#downvote-button-' + answerId);
            if (answerVote.score === 1) {
                upvoteButton.classList.add('btn-outline-success');
            } else if (answerVote.score === -1) {
                downvoteButton.classList.add('btn-outline-danger');
            }
        }

    });

}


let notificationsButton = document.getElementById('notifications-icon');
if (notificationsButton) {
        sendAjaxRequest('POST', '/api/get_unread_notifications', {id_user: loggedUser.id_user}, function () {
            let response = JSON.parse(this.responseText);
            let notifications = response.notifications;
            //create a list of notifications
            let notificationsList = document.createElement('ul');
            /*notificationsList.classList.add('list-group');
            notificationsList.classList.add('list-group-flush');
            notificationsList.classList.add('list-group-hoverable');
            notificationsList.classList.add('list-group-hoverable-dark');
            */
            notificationsList.setAttribute('id', 'notifications-list');
            //for each notification, create a list item and add it to the list
            if(notifications.length === 0) {
                let noNotifications = document.createElement('li');
                noNotifications.classList.add('list-group-item');
                noNotifications.textContent = 'No new notifications';
                notificationsList.appendChild(noNotifications);
            }
            for (let notification of notifications) {
                let notificationListItem = document.createElement('li');
                notificationListItem.classList.add('list-group-item');
                notificationListItem.classList.add('list-group-item-dark');
                notificationListItem.classList.add('list-group-item-action');
                notificationListItem.classList.add('list-group-item-action-dark');
                notificationListItem.setAttribute('id', 'notification-' + notification.id_notif);
                //add a mark as read button
                let markAsReadButton = document.createElement('button');
                markAsReadButton.classList.add('btn');
                markAsReadButton.classList.add('btn-sm');
                markAsReadButton.classList.add('btn-outline-dark');
                markAsReadButton.classList.add('mark-as-read-button');
                markAsReadButton.textContent = 'Mark as read';
                markAsReadButton.setAttribute('id', 'mark-as-read-button-' + notification.id_notif);
                //align the button to the right
                markAsReadButton.style.float = 'right';
                markAsReadButton.addEventListener('click', function () {
                    sendAjaxRequest('POST', '/api/dismiss_notification', {id_user: loggedUser.id_user, id_notification: notification.id_notif}, null);
                    let notificationListItem = document.getElementById('notification-' + notification.id_notif);
                    notificationListItem.classList.add('fade');
                    notificationListItem.classList.add('out');
                    setTimeout(function () {
                        notificationListItem.remove();
                        notifications.splice(notifications.indexOf(notification), 1);

                        if(notifications.length === 0) {
                            let noNotifications = document.createElement('li');
                            noNotifications.classList.add('list-group-item');
                            noNotifications.textContent = 'No new notifications';
                            notificationsList.appendChild(noNotifications);
                        }
                    }, 500);

                });


                notificationListItem.addEventListener('click', function () {
                    sendAjaxRequest('POST', '/api/dismiss_notification', {id_user: loggedUser.id_user, id_notification: notification.id_notif}, null);
                });
                let notificationLink = document.createElement('a');
                notificationLink.classList.add('text-decoration-none');
                notificationLink.classList.add('text-dark');
                notificationLink.textContent = notification.message;
                if(notification.href) notificationLink.setAttribute('href', notification.href);
                notificationListItem.appendChild(notificationLink);
                notificationListItem.appendChild(markAsReadButton);
                notificationsList.appendChild(notificationListItem);
            }
            //add the list to the dropdown menu
            document.querySelector('#notifications-icon').appendChild(notificationsList);
        });
}
