<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;

use App\Models\Post;
use App\Models\Question;
use App\Models\Answer;

class HomeController extends Controller
{
    /**
     * @return Response
     */
    public function home()
    {      

      return view('pages.home');
    }
}

