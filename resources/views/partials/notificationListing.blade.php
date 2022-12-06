@php include_once(app_path() . '/Includes/Utils.php');

if($notification->system_notification) {
    $href = null;
    $notificationText = $notification->system_notification->notif_text;
}
elseif($notification->follow_tag_notification) {
    $href = route('tags', ['name' => $notification->follow_tag_notification->tag->name]);
//    $notificationText = 'Check out the new posts with the tag ' . $notification->follow_tag_notification->tag->name;
    $notificationText = $notification->follow_tag_notification->tag->name;
}
elseif($notification->marked_as_solution_notification) {
    $href = route('question', ['id_question' => $notification->marked_as_solution_notification->answer->question->id_question]) . '#answerid-' . $notification->marked_as_solution_notification->answer->id_post;
//    $notificationText = 'Your answer to the question «' . $notification->marked_as_solution_notification->answer->question->title . '» was marked as the solution';
    $notificationText =  $notification->marked_as_solution_notification->answer->question->title;
}
elseif($notification->new_badge_notification) {
    $href = route('users', ['id_user' => $notification->user->id_user]);
//    $notificationText = 'You earned the ' . $notification->new_badge_notification->badge->name . ' badge';
    $notificationText = $notification->new_badge_notification->badge->name;
}
elseif($notification->new_answer_notification) {
    $href = route('question', ['id_question' => $notification->new_answer_notification->answer->question->id_question]) . '#answerid-' . $notification->new_answer_notification->answer->id_answer;
//    $notificationText = 'There is a new answer to your question «' . $notification->new_answer_notification->answer->question->title . '»';
    $notificationText =  $notification->new_answer_notification->answer->question->title;
}
elseif($notification->followed_question_notification) {
    $href = route('question', ['id_question' => $notification->followed_question_notification->question->id_question]) . '#answerid-' . $notification->followed_question_notification->answer->id_answer;
//    $notificationText = 'There is a new answer to the question «' . $notification->followed_question_notification->question->title . '»';
    $notificationText = $notification->followed_question_notification->question->title;
}
else{
    dump($notification);
    $href = null;
    $notificationText = "Unknown notification";
}

@endphp

<div class="card bg-light mb-3">
    <div class="flex  g-0">
        <div class="col-md-2">
            <div class="card-body" >
               <h5 id="notification-time-ago-id-{{$notification->id_notif}}" class="card-title text-decoration-none @if(!$notification->dismissed)fw-bold @endif"
                data-bs-toggle="tooltip" data-bs-placement="top" title="{{date('d/m/Y H:i:s', strtotime($notification->date))}}"
                >{{timeElapsedString($notification->date)}}</h5>

            </div>
        </div>
        <div class="notification-card col-md-20">
            <div class="card-body">
                <h5 id="notification-header-id-{{$notification->id_notif}}" class="notification-header card-title text-decoration-none @if(!$notification->dismissed)fw-bold @endif">

                    @if($notification->new_answer_notification)
                        <p>There is a new answer to your question «
                        <a id="notification-anchor-{{$notification->id_notif}}" href="{{$href}}" class="notification-anchor text-decoration-none @if($notification->dismissed) text-muted @endif">
                            {{$notificationText}}
                        </a>
                            ».
                        </p>
                    @elseif($notification->followed_question_notification)
                        <p>There is a new answer to the question «
                        <a id="notification-anchor-{{$notification->id_notif}}" href="{{$href}}" class="notification-anchor text-decoration-none @if($notification->dismissed) text-muted @endif">
                            {{$notificationText}}
                        </a>
                            ».
                        </p>
                    @elseif($notification->marked_as_solution_notification)
                        <p>Your answer to the question «
                        <a id="notification-anchor-{{$notification->id_notif}}" href="{{$href}}" class="notification-anchor text-decoration-none @if($notification->dismissed) text-muted @endif">
                            {{$notificationText}}
                        </a>
                            » was marked as the solution.
                        </p>
                    @elseif($notification->new_badge_notification)
                        <p>You earned the
                        <a id="notification-anchor-{{$notification->id_notif}}" href="{{$href}}" class="notification-anchor text-decoration-none @if($notification->dismissed) text-muted @endif">
                            {{$notificationText}}
                        </a>
                            badge.
                        </p>
                    @elseif($notification->follow_tag_notification)
                        <p>Check out the new posts with the tag
                        <a id="notification-anchor-{{$notification->id_notif}}" href="{{$href}}" class="notification-anchor text-decoration-none @if($notification->dismissed) text-muted @endif">
                            {{$notificationText}}
                        </a>
                        </p>
                    @elseif($notification->system_notification)
                        <p>
                            {{$notificationText}}.
                        </p>

                    @else
                        {{$notificationText}}.
                    @endif

                </h5>
            </div>
        </div>

        <div class="col-md-5">
            <div class="card-body">
                <h5 class="card-title">
                    @if(!$notification->dismissed)
                        <button id="notification-read-button-id-{{$notification->id_notif}}" class="btn btn-outline-dark btn-sm mark-as-read-notification" type="button"> {{-- data-bs-toggle="tooltip" data-bs-placement="top" title="Mark as read"> --}}
                            Mark as read
                        </button>
                    @endif
                </h5>
                </div>
        </div>

    </div>
</div>

