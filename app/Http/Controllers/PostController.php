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
        $sortReceived = $request->query('sort');
        $orderReceived = $request->query('order');
        if($sortReceived !== 'date' && $sortReceived !== 'score'){
            $sort = '';
        }
        else{
            $sort = $sortReceived;
        }
        if($orderReceived == 'ascending') {
            $order = 'ASC';
        }
        else{
            $order = 'DESC';
        }

        if($filters === null){
            $filters = 'all';
        }

        if($filters == 'questions') {
            if ($sort === 'score') {
                $posts = Post::query()
                    ->whereRaw('id_post IN (SELECT id_question FROM question)')
                    ->whereRaw('tsvectors @@ plainto_tsquery(\'english\', ?) OR text_body LIKE ? or (SELECT title FROM question WHERE id_question = id_post) LIKE ?', ["%$query%", "%$query%", "%$query%"])
                    ->orderByRaw('ts_rank(tsvectors, plainto_tsquery(\'english\',?)) DESC', "%$query%")
                    ->orderByRaw('(SELECT score FROM question WHERE id_post = id_question), ?', $order)
                    ->paginate(20);
            } else if ($sort === 'date') {
                $posts = Post::query()
                    ->whereRaw('id_post IN (SELECT id_question FROM question)')
                    ->whereRaw('tsvectors @@ plainto_tsquery(\'english\', ?) OR text_body LIKE ? or (SELECT title FROM question WHERE id_question = id_post) LIKE ?', ["%$query%", "%$query%", "%$query%"])
                    ->orderByRaw('ts_rank(tsvectors, plainto_tsquery(\'english\',?)) DESC', "%$query%")
                    ->orderBy('date', $order)
                    ->paginate(20);
            } else {
                $posts = Post::query()
                    ->whereRaw('id_post IN (SELECT id_question FROM question)')
                    ->whereRaw('tsvectors @@ plainto_tsquery(\'english\', ?) OR text_body LIKE ? or (SELECT title FROM question WHERE id_question = id_post) LIKE ?', ["%$query%", "%$query%", "%$query%"])
                    ->orderByRaw('ts_rank(tsvectors, plainto_tsquery(\'english\',?)) DESC', "%$query%")
                    ->paginate(20);
            }
        }
        else if($filters == 'answers'){
            if($sort === 'score') {
                $posts = Post::query()
                    ->whereRaw('id_post IN (SELECT id_answer FROM answer)')
                    ->whereRaw('tsvectors @@ plainto_tsquery(\'english\', ?) OR text_body LIKE ?', ["%$query%", "%$query%"])
                    ->orderByRaw('ts_rank(tsvectors, plainto_tsquery(\'english\',?)) DESC', "%$query%")
                    ->orderByRaw('(SELECT score FROM answer WHERE id_answer = id_post), ?', [$order])
                    ->paginate(20);
            }
            else if($sort === 'date'){
                $posts = Post::query()
                    ->whereRaw('id_post IN (SELECT id_answer FROM answer)')
                    ->whereRaw('tsvectors @@ plainto_tsquery(\'english\', ?) OR text_body LIKE ?', ["%$query%", "%$query%"])
                    ->orderByRaw('ts_rank(tsvectors, plainto_tsquery(\'english\',?)) DESC', "%$query%")
                    ->orderBy('date', $order)
                    ->paginate(20);
            }
            else{
                $posts = Post::query()
                    ->whereRaw('id_post IN (SELECT id_answer FROM answer)')
                    ->whereRaw('tsvectors @@ plainto_tsquery(\'english\', ?) OR text_body LIKE ?', ["%$query%", "%$query%"])
                    ->orderByRaw('ts_rank(tsvectors, plainto_tsquery(\'english\',?)) DESC', "%$query%")
                    ->paginate(20);
            }
        }
        else{
            if($sort === 'score') {
                $posts = Post::query()
                    ->whereRaw('(id_post IN (SELECT id_question FROM question)
                 or id_post IN (SELECT id_answer FROM answer)) and tsvectors @@ plainto_tsquery(\'english\', ?) OR text_body LIKE ? OR (SELECT title FROM question WHERE id_question = id_post) LIKE ?', ["%$query%", "%$query%", "%$query%"])
                    ->orderByRaw('ts_rank(tsvectors, plainto_tsquery(\'english\',?)) DESC', "%$query%")
                    ->orderByRaw('(SELECT score FROM answer WHERE id_answer = id_post),  ?', [$order])
                    ->paginate(20);
            }
            else if($sort === 'date') {
                $posts = Post::query()
                    ->whereRaw('(id_post IN (SELECT id_question FROM question)
                 or id_post IN (SELECT id_answer FROM answer)) and tsvectors @@ plainto_tsquery(\'english\', ?) OR text_body LIKE ? OR (SELECT title FROM question WHERE id_question = id_post) LIKE ?', ["%$query%", "%$query%", "%$query%"])
                    ->orderByRaw('ts_rank(tsvectors, plainto_tsquery(\'english\',?)) DESC', "%$query%")
                    ->orderBy('date', $order)
                    ->paginate(20);
            }
            else{
                $posts = Post::query()
                    ->whereRaw('(id_post IN (SELECT id_question FROM question)
                 or id_post IN (SELECT id_answer FROM answer)) and tsvectors @@ plainto_tsquery(\'english\', ?) OR text_body LIKE ? OR (SELECT title FROM question WHERE id_question = id_post) LIKE ?', ["%$query%", "%$query%", "%$query%"])
                    ->orderByRaw('ts_rank(tsvectors, plainto_tsquery(\'english\',?)) DESC', "%$query%")
                    ->paginate(20);
            }
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
        $posts =  Post::query()->orderBy('date', 'DESC')
            ->whereIn('id_post', Question::query()
                ->get(['id_question']))
            ->paginate(20);

        return view('pages.allQuestions', ['posts' => $posts]);
    }

    public function showAllPosts(){
        $posts =  Post::query()->orderBy('date', 'DESC')->paginate(20);

        return view('pages.home', ['posts' => $posts]);
    }
    public function showTopQuestions(){
        $date = date('Y-m-d', strtotime('-2 months'));
        $posts =  Post::query()->whereIn('id_post', Question::query()->get(['id_question']))
            ->orderByRaw('(SELECT score FROM question WHERE id_post = id_question) DESC')
            ->orderByRaw('(SELECT count(id_question) FROM answer WHERE id_question = id_post) DESC')
            ->where('date','>',$date)
            ->paginate(20);

        return view('pages.home', ['posts' => $posts]);
    }

    public function updatePostForm($id){
        $post = Post::find($id);
        return view('pages.editQuestion', ['post' => $post]);
    }

    public function update(Request $request){
        //dar update
    }

    public function delete(Request $request){
        //remover
    }

    
}

