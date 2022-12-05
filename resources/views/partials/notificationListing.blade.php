@php include_once(app_path() . '/Includes/Utils.php');

if($notification->system_notification) {
    $href = null;
    $notificationText = $notification->system_notification->notif_text;
}
elseif($notification->follow_tag_notification) {
    $href = route('tags', ['name' => $notification->follow_tag_notification->tag->name]);
    $notificationText = 'Check out the new posts with the tag ' . $notification->follow_tag_notification->tag->name;
}
elseif($notification->marked_as_solution_notification) {
    $href = route('question', ['id_question' => $notification->marked_as_solution_notification->answer->question->id_question]) . '#answerid-' . $notification->marked_as_solution_notification->answer->id_post;
    $notificationText = 'Your answer to the question «' . $notification->marked_as_solution_notification->answer->question->title . '» was marked as the solution';
}
elseif($notification->new_badge_notification) {
    $href = route('users', ['id_user' => $notification->user->id_user]);
    $notificationText = 'You earned the ' . $notification->new_badge_notification->badge->name . ' badge';
}
elseif($notification->new_answer_notification) {
    $href = route('question', ['id_question' => $notification->new_answer_notification->answer->question->id_question]) . '#answerid-' . $notification->new_answer_notification->answer->id_answer;
    $notificationText = 'There is a new answer to your question «' . $notification->new_answer_notification->answer->question->title . '»';
}
elseif($notification->followed_question_notification) {
    $href = route('question', ['id_question' => $notification->followed_question_notification->question->id_question]) . '#answerid-' . $notification->followed_question_notification->answer->id_answer;
    $notificationText = 'There is a new answer to the question «' . $notification->followed_question_notification->question->title . '»';
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
               <h5 class="card-title text-decoration-none @if(!$notification->dismissed)fw-bold @endif"
                data-bs-toggle="tooltip" data-bs-placement="top" title="{{date('d/m/Y H:i:s', strtotime($notification->date))}}"
                >{{timeElapsedString($notification->date)}}</h5>

            </div>
        </div>
        <div class="col-md-10">
            <div class="card-body">



                <h5 class="card-title text-decoration-none @if(!$notification->dismissed)fw-bold @endif">
                    @if($href)
                        <a href="{{$href}}" class="text-decoration-none @if($notification->dismissed) text-muted @endif">
                            {{$notificationText}}
                        </a>
                    @else
                        {{$notificationText}}
                    @endif
                </h5>







            </div>
        </div>

        <div class="col-md-5">
            <div class="card-body">
                <h5 class="card-title">
                    @if(!$notification->dismissed)
                        <button class="btn btn-outline-dark btn-sm" type="button"> {{-- data-bs-toggle="tooltip" data-bs-placement="top" title="Mark as read"> --}}
                            Mark as read
                        </button>
                    @endif
                </h5>
                </div>
        </div>

    </div>
</div>

