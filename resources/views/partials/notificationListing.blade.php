@php include_once(app_path() . '/Includes/Utils.php');

if($notification->system_notification) {
    $notificationText = $notification->system_notification->notif_text;
    $href = null;
}
elseif($notification->follow_tag_notification) {
    $notificationText = 'Check out the new posts with the tag ' . $notification->follow_tag_notification->tag->name;
    $href = route('tags', ['name' => $notification->follow_tag_notification->tag->name]);
}
elseif($notification->marked_as_solution_notification) {
    $notificationText = 'Your answer to the question « ' . $notification->marked_as_solution_notification->answer->question->title . ' » was marked as the solution';
    $href = route('question', ['id_question' => $notification->marked_as_solution_notification->answer->question->id_question]) . '#answerid-' . $notification->marked_as_solution_notification->answer->id_post;
}
elseif($notification->new_badge_notification) {
    $notificationText = 'You earned the ' . $notification->new_badge_notification->badge->name . ' badge';
    $href = route('users', ['id_user' => $notification->user->id_user]);
}
elseif($notification->new_answer_notification) {
    $notificationText = 'There is a new answer to your question « ' . $notification->new_answer_notification->answer->question->title . ' »';
    $href = route('question', ['id_question' => $notification->new_answer_notification->answer->question->id_question]) . '#answerid-' . $notification->new_answer_notification->answer->id_answer;
}
elseif($notification->followed_question_notification) {
    $notificationText = 'There is a new answer to the question « ' . $notification->followed_question_notification->question->title . ' »';
    $href = route('question', ['id_question' => $notification->followed_question_notification->question->id_question]) . '#answerid-' . $notification->followed_question_notification->answer->id_answer;
}
else{
    dump($notification);
    $notificationText = "Unknown notification";
    $href = null;
}

@endphp



<div class="card bg-light mb-3">
    {{-- make this div a grid with two collumns--}}
    <div class="row g-0">
        <div class="col-md-2">
            <div class="card-body" data-bs-toggle="tooltip" data-bs-placement="top" title="{{date('d/m/Y H:i:s', strtotime($notification->date))}}">
              <a href="{{$href}}">  <h5 class="card-title @if(!$notification->dismissed)fw-bold @endif
                ">{{timeElapsedString($notification->date)}}</h5>
              </a>
            </div>
        </div>
        <div class="col-md-10">
            <div class="card-body">
                <h5 class="card-title
                ">{{$notificationText}}</h5>
            </div>
        </div>
    </div>
</div>

