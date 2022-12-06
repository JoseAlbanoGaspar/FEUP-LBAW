<?php

namespace App\Http\Controllers;

use App\Models\AnswerVote;
use App\Models\Post;
use App\Models\Question;
use App\Models\QuestionVote;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Validator;

use App\Models\User;
use App\Models\Administrator;
use App\Models\Moderator;
use Throwable;

class UserController extends Controller
{
    /**
     * Get the number of upvotes and downvotes a user given to posts
     * @param $posts
     * @return array|int[]
     */
    public function postScore($posts){
      $upPost = 0;
      $downPost = 0;

      foreach($posts as $vote){
        if($vote->score == 1) $upPost = $upPost + 1;
        if($vote->score == -1) $downPost = $downPost + 1;
      }

        return ['up' => $upPost,'down' => $downPost];
    }
    /**
     * Shows the user for a given id.
     * @param  int  $id
     * @return \Illuminate\Contracts\Foundation\Application|\Illuminate\Contracts\View\Factory|\Illuminate\Contracts\View\View
     */
    public function show($id)
    {
      $user = User::find($id);
      $role = 'Standard User';
      if(Moderator::find($id)) $role = 'Moderator';
      else if(Administrator::find($id)) $role = 'Administrator';

      $question_votes = $this->postScore($user->question_votes()->get());
      $answer_votes = $this->postScore($user->answer_votes()->get());

      return view('pages.profile', ['user' => $user, 'role'=> $role,'question_votes' => $question_votes,'answer_votes' => $answer_votes]);
    }

    /**
     * Get the page to edit a user
     * @param $id
     * @return \Illuminate\Contracts\Foundation\Application|\Illuminate\Contracts\View\Factory|\Illuminate\Contracts\View\View
     * @throws \Illuminate\Auth\Access\AuthorizationException
     */
    public function getEditProfile($id){
      $user = User::find($id);
      $this->authorize('editProfile',$user);
      return view('pages.edit', ['user' => $user]);
    }

    /**
     * Update user information
     * @param Request $request
     * @return \Illuminate\Http\RedirectResponse
     * @throws \Illuminate\Auth\Access\AuthorizationException
     */
    public function update(Request $request){
      $user = User::find($request->id_user);

      $this->authorize('editProfile',$user);
      //validate results
      $validator = Validator::make($request->all(),[
            'username' => 'min:5|max:25|regex:/^((?!deleted_user).)*$/',
            'email' => 'min:5|max:50|regex:/^((?!deleted_email).)*$/|regex:/^([a-zA-Z0-9_\-\.]+)@([a-zA-Z0-9_\-\.]+)\.([a-zA-Z]{2,5})$/',
            'personal_text' => 'max:255',
            'password' => 'nullable|confirmed|min:6',
      ]);

      if($validator->fails()){
        return redirect()->route('editProfile',['id_user' => $user->id_user])->withInput()->withErrors($validator);
      }

      //updating...
      $user->username = strtolower($request->name);
      $user->email = strtolower($request->email);
      $user->personal_text = $request->personal_text;
      if($request->password != NULL) $user->password = bcrypt($request->password);

      $img = $request->profile_picture;
      if($img != null){
          $path = 'storage/images/';
          $imageName = Auth::id(). '-profile-picture.' . $img->extension();
          $img->storeAs('public/images', $imageName);
          $user->profile_picture = $path . $imageName;
      }

      //store updated information
      $user->save();
      return redirect()->route('editProfile',['id_user' => $user->id_user]);
    }


    /**
     * Search for users and return a view with the results
     * @param Request $request
     * @return \Illuminate\Contracts\Foundation\Application|\Illuminate\Contracts\View\Factory|\Illuminate\Contracts\View\View
     */
    public function search(Request $request){
        $query = $request->query('query');
        $users = User::query()
            ->where('username','LIKE', "%{$query}%")
            ->orderBy('username', 'ASC')
            ->simplePaginate(10);
        return view('pages.searchUsers', ['users' => $users, 'query' => $query]);
    }

    /**
     * Search for users and return a rendered view with the results for AJAX
     * @param Request $request
     * @return \Illuminate\Http\JsonResponse
     */
    public function searchApi(Request $request){
        $query = $request->input('query');
        $page = $request->input('page');
        if(is_null($page)){
            $page = 1;
        }
        else{
            $page = intval($page);
        }
        $users = User::query()
            ->where('username','LIKE', "%{$query}%")
            ->orderBy('username', 'ASC')
            ->simplePaginate(10, ['*'], 'page', $page);

        $returnHTML = view('pages.searchUsers', ['users' => $users, 'query' => $query])->render();
        return response()->json(array('success' => true, 'html'=>$returnHTML));
    }
    /**
     * Get a validator for an incoming registration request.
     *
     * @param  array  $data
     * @return \Illuminate\Contracts\Validation\Validator
     */
    public static function validator(array $data)
    {
        return Validator::make($data, [
            'username' => 'required|string|min:5|regex:/^((?!deleted_user).)*$/|max:25|unique:users',
            'email' => 'required|string|email|min:5|max:50|regex:/^((?!deleted_email).)*$/|regex:/^([a-zA-Z0-9_\-\.]+)@([a-zA-Z0-9_\-\.]+)\.([a-zA-Z]{2,5})$/|unique:users',
            'password' => 'required|string|min:6|confirmed',
            'personal_text' => 'max:255',
            'terms'=> 'accepted'
        ]);
    }

    /**
     * Create a new user instance after a valid registration.
     *
     * @param  array  $data
     * @return \App\Models\User
     */
    public static function create(array $data)
    {
        $path = 'storage/images/';
        $profile_image_url = $path . 'default-user.jpg';



        if(array_key_exists('profile_picture', $data)){
            $img = $data['profile_picture'];
            $new_id = DB::table('users')->latest('id_user')->first()->id_user + 1;

            $imageName = strval($new_id). '-profile-picture.' . $img->extension();
            $img->storeAs('public/images', $imageName);
            $profile_image_url = $path . $imageName;
        }

        return User::create([
            'username' => strtolower($data['username']),
            'email' => strtolower($data['email']),
            'password' => bcrypt($data['password']),
            'personal_text' => $data['personal_text'],
            'profile_picture' => $profile_image_url
        ]);
    }

    public function getCurrentUserApi(){
//        if(Auth::check()){
//            $user = Auth::user();
////           $user = User::find(1);
//        }
//        else{
//            $user = null;
//            $user = User::find(1);
//        }

        if (Auth::guard('api')->check())
        {
//            logger(Auth::guard('api')->user()); // to get user
            $user = Auth::guard('api')->user();

        }else{
//            logger("User not authorized");
            $user = 33;
        }
        return  response()->json(array('success' => true, 'user'=>$user));
    }

    public function userVotesToQuestionAndAnswers($id_user, $id_question){

        //verificar se user logado ou admin??
        $questionVote = User::find($id_user)->question_votes()->where('id_question', $id_question)->get();
        $answerVotes = User::find($id_user)->answer_votes()->whereIn('id_answer', Question::find($id_question)->answers()->pluck('id_answer'))->get();
        return response()->json(array('success' => true, 'questionVote'=>$questionVote, 'answerVotes'=>$answerVotes));
    }

    public function voteOnPost(Request $request){

        $id_user = $request->id_user;
        $id_post = $request->id_post;

        $score = intval($request->score);
        $post = Post::find($id_post);
        if($post->question != null){
            $vote = QuestionVote::where('id_question', $id_post)->where('id_user', $id_user)->first();
            if($vote == null){
                QuestionVote::create(['id_question' => $id_post, 'id_user' => $id_user, 'score' => $score]);
            }
            else{
                QuestionVote::where('id_question', $id_post)->where('id_user', $id_user)->update(['score' => $score]);
            }
        }
        elseif ($post->answer != null){
            $vote = AnswerVote::where('id_answer', $id_post)->where('id_user', $id_user)->first();
            if($vote == null){
                AnswerVote::create(['id_answer' => $id_post, 'id_user' => $id_user, 'score' => $score]);
            }
            else{
                AnswerVote::where('id_answer', $id_post)->where('id_user', $id_user)->update(['score' => $score]);
            }
        }
        else{
            return response()->json(array('success' => false, 'message'=>'Post not found'));
        }
        return response()->json(array('success' => true));
    }


}
