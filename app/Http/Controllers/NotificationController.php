<?php

namespace App\Http\Controllers;

use App\Models\User;
use Illuminate\Auth\Access\AuthorizationException;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Validator;
use Illuminate\Support\Facades\DB;
use DateTime;
use Illuminate\Support\Facades\Log;
use App\Models\Notification;
use App\Models\Badge;
use Throwable;


class NotificationController extends Controller
{
    public function show(){
        $notifications = auth()->user()->notifications()->orderBy('dismissed', 'asc')->orderBy('date','desc')->paginate(10);
        return view('pages.notifications',compact('notifications'));
    }

    /**
     * @throws AuthorizationException
     */
    public function dismissNotification(Request $request){
        $id_user = $request->input('id_user');
        $id_notification = $request->input('id_notification');
        try {
            $user = User::findOrFail($id_user);
        } catch (Throwable $e) {
            abort(404);
        }
        try {
            $notification = Notification::findOrFail($id_notification);
        } catch (Throwable $e) {
            abort(404);
        }


        //!!!!!!!!!!!!!!!!!!!!! náo chama a policy sabe-se lá porquÊ
//        $this->authorize('owner', [Notification::class, $user, $notification]);

        $notification->dismissed = true;
        $notification->save();
        return response()->json(array('success' => true));
    }
    public function dismissAllNotifications(Request $request){
        $id_user = $request->input('id_user');
        try {
            $user = User::findOrFail($id_user);
        } catch (Throwable $e) {
            abort(404);
        }

        $notifications = $user->notifications()->get();
        foreach ($notifications as $notification){
            $notification->dismissed = true;
            $notification->save();
        }

        return response()->json(array('success' => true));
    }
    public function getUnreadNotifications(Request $request){
        $id_user = $request->input('id_user');
        try {
            $user = User::findOrFail($id_user);
        } catch (Throwable $e) {
            abort(404);
        }
        $notifications = $user->notifications()->where('dismissed', false)->orderBy('dismissed', 'asc')->orderBy('date','desc')->limit(10)->get();

        foreach ($notifications as $notification){
            if($notification->system_notification) {
                $notification->href = null;
                $notification->message = $notification->system_notification->notif_text;
            }
            elseif($notification->follow_tag_notification) {
                $notification->href = route('tags', ['name' => $notification->follow_tag_notification->tag->name]);
                $notification->message = 'Check out the new posts with the tag ' . $notification->follow_tag_notification->tag->name;
            }
            elseif($notification->marked_as_solution_notification) {
                $notification->href = route('question', ['id_question' => $notification->marked_as_solution_notification->answer->question->id_question]) . '#answerid-' . $notification->marked_as_solution_notification->answer->id_post;
                $notification->message = 'Your answer to the question «' . $notification->marked_as_solution_notification->answer->question->title . '» was marked as the solution';
            }
            elseif($notification->new_badge_notification) {
                $notification->href = route('users', ['id_user' => $notification->user->id_user]);
                $notification->message = 'You earned the '. $notification->new_badge_notification->badge->name . ' badge';
            }
            elseif($notification->new_answer_notification) {
                $notification->href = route('question', ['id_question' => $notification->new_answer_notification->answer->question->id_question]) . '#answerid-' . $notification->new_answer_notification->answer->id_answer;
                $notification->message = 'There is a new answer to your question «' . $notification->new_answer_notification->answer->question->title . '»';
            }
            elseif($notification->followed_question_notification) {
                $notification->href = route('question', ['id_question' => $notification->followed_question_notification->question->id_question]) . '#answerid-' . $notification->followed_question_notification->answer->id_answer;
                $notification->message = 'There is a new answer to the question «' . $notification->followed_question_notification->question->title . '»';
            }
            else{
                $notification->href = null;
                $notification->message = "Unknown notification";
            }
            $notification->message = (strlen($notification->message) > 203) ? substr($notification->message,0,200).'...' :
                $notification->message;
        }


        return response()->json(array('success' => true, 'notifications' => $notifications));
    }
}
