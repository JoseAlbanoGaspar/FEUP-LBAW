<?php
namespace App\Http\Controllers;

use Illuminate\Http\Request;

use App\Models\Tag;

class TagController extends Controller
{
    /**
     * Shows the user for a given id.
     *
     * @param  int  $id
     * @return Response
     */
    public function createTag(Request $req){
        Tag::create(['name' => $req->tag]);
        return redirect()->back();
    }

    public function deleteTag(Request $req){
        $tag = Tag::find($req->id_tag);
        $tag->delete();
        return redirect()->back();
    }

} 