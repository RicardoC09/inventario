<?php

namespace App\Http\Controllers;


use Illuminate\Http\Request;
use App\get_user;
use App\User;
use App\person;
use Auth;

use Illuminate\Support\Facades\Storage;
use Illuminate\Support\Facades\DB;
use Prophecy\Call\Call;

class UsersController extends Controller
{
    public function getUser (){
        $user_id = Auth::user()->id;
        $query = DB::select('CALL get_user(?)',[$user_id]);
        return response()->json($query);
    }
    public function getUsers (){
        $query = DB::select('CALL get_users');
        return response()->json($query);
    }
    public function getDocumentTypes (){
        $query = DB::select('CALL get_document_types');
        return response()->json($query);
    }
    public function getPositions (){
        $query = DB::select('CALL get_positions');
        return response()->json($query);
    }
    public function getRoles (){
        $query = DB::select('CALL get_roles');
        return response()->json($query);
    }

    public function setUserNew (Request $request){
        $user = new User;
        $user->name = $request->name;
        $user->email = $request->email;
        $user->password = bcrypt($request->password);
        $user->save();

        $file = $request->file('file');
        $date = date('Y-m-d H:i:s');
        $date =  str_replace(":", "_", $date);
        $ext = $file->extension();
        $avatar =$user->id .'-Foto-'.$date.'.'.$ext;
        Storage::disk('avatar')->put($avatar, file_get_contents($file->getRealPath()));

        $people = new person;
        $people->user_id = $user->id;
        $people->document_Type_id =$request->documenType;
        $people->document_Number =$request->documentNunber;
        $people->rol_id =$request->rolType;
        $people->position_id =$request->position;
        $people->avatar =$avatar;
        $people->save();
        return response()->json($people);
    }
    
}
