<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Auth;

use App\Models\Report;

class ReportController extends Controller
{
    public function checkReport($id_user,$id_post){
        return Report::where([
            ['id_user','=',$id_user],
            ['id_post','=',$id_post]
        ])->first();
    }
    
    public function addReport(Request $request)
    {       
        if($this->checkReport($request->id_user,$request->id_post)){
            //error handling   DO THIS
            return redirect()->back();  
        }

        //adding report
        Report::create([
            'id_post' => $request->id_post,
            'id_user' => $request->id_user,
            'reason' => $request->reason
        ]);

        return redirect()->back();
    }

    public function dismiss(Request $request){
        if(!Auth::user()->moderator && !Auth::user()->administrator)
            abort(404);
                
        $found = Report::where('id_post',$request->id_post)->delete();
        
        return redirect()->back();
    }
}