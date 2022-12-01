<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;

use App\Models\Report;

class ReportController extends Controller
{
    public function addReport(Request $request)
    {
        //check if user can report
        $found = DB::table('report')->where([
            ['id_user','=',$request->id_user],
            ['id_post','=',$request->id_post]
        ])->first();
        
        if($found){
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
}