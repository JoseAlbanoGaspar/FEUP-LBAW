<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;

use App\Models\Post;
use Illuminate\Support\Facades\Auth;
use App\Models\Question;
use App\Models\Answer;
use App\Models\User;

class PostController extends Controller
{
    /**
     * Shows the user for a given id.
     *
     * @param  int  $id
     * @return Response
     */
    public function show($id_user)
    {

      return view('posts.post', ['post' => $post]);
    }

    /**
     * Shows all questions asked for the user with a given id.
     * @param int $id_user
     * @return Response
     */
    public function showQuestions($id_user){
        $posts = User::find($id_user)->posts()->get();
        $questions = $posts->filter(
            function($post){
                return $post->question != null;
            }
        );
        return view('pages.myquestions',['questions' => $questions]);
    }

    /**
     * Shows all answers (and the questions in context) for the user with a given id.
     * @param int $id_user
     * @return Response
     */
    public function showAnswers($id_user){
      $posts = User::find($id_user)->posts()->get();
      $answers = $posts->filter(
          function($post){
              return $post->answer != null;
          }
      );

      return view('pages.myanswers',['answers' => $answers]);
  }


    //function that receives a string query and returns a list of posts that match that query
    public function search(Request $request){
        $query = $request->query('query');
        $filters = $request->query('filters');

        if($filters === null){
            $filters = 'all';
        }

        if($filters == 'questions'){
            $posts =  Post::query()
                ->whereRaw('id_post IN (SELECT id_question FROM question)')
                ->whereRaw('tsvectors @@ plainto_tsquery(\'english\', ?)', "%{$query}%")
                ->orderByRaw('ts_rank(tsvectors, plainto_tsquery(\'english\',?)) DESC', "%{$query}%")
                ->get();
        }
        else if($filters == 'answers'){
            $posts =  Post::query()
                ->whereRaw('id_post IN (SELECT id_answer FROM answer)')
                ->whereRaw('tsvectors @@ plainto_tsquery(\'english\', ?)', "%{$query}%")
                ->orderByRaw('ts_rank(tsvectors, plainto_tsquery(\'english\',?)) DESC', "%{$query}%")
                ->get();
        }
        else{
            $posts =  Post::query()
                ->whereRaw('(id_post IN (SELECT id_question FROM question)
                 or id_post IN (SELECT id_answer FROM answer)) and tsvectors @@ plainto_tsquery(\'english\', ?)', "%{$query}%")
                ->orderByRaw('ts_rank(tsvectors, plainto_tsquery(\'english\',?)) DESC', "%{$query}%")
                ->get();
        }

        return view('pages.search', ['posts' => $posts]);

    }
    public function personalFeed(){
        if(Auth::check()){
            $user = Auth::user();
        }
        else{
            return redirect('login');
        }
        $posts =  Post::query()->orderBy('date', 'DESC')->get();


        $questions = $posts->filter(
            function ($post) {
                return $post->question != null;
            }
        );

        $userTags = $user->followed_tags;

        $questions = $questions->sortByDesc(
            function ($question) use ($userTags) {
                $questionTags = $question->question->tags;
                $intersect = $questionTags->intersect($userTags);
                return $intersect->count();
            }
        );

        $questions = $questions->take(30);

        return view('pages.personalFeed', ['posts' => $questions]);
    }

    public function showAllQuestions(){
        $posts =  Post::query()->orderBy('date', 'DESC')->whereIn('id_post', Question::query()->get(['id_question']))->paginate(20);

        return view('pages.allQuestions', ['posts' => $posts]);
    }

    public function showAllPosts(){
        $posts =  Post::query()->orderBy('date', 'DESC')->paginate(20);

        return view('pages.home', ['posts' => $posts]);
    }
}

