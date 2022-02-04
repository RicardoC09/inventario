<?php

namespace App\Http\Controllers;

use App\Proceedings;
use App\Document;
use App\Seccion;
use App\Serie;
use App\SubSerie;
use App\SubProceedings;
use App\SubSection;
use App\getSerie;
use App\getDataAll;
use App\getUsers;
use App\getSeccionAll;
use Auth;

use Illuminate\Support\Facades\Storage;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth as FacadesAuth;
use Illuminate\Support\Facades\DB;
use Prophecy\Call\Call;

class DocumentController extends Controller
{
    public function getSeccions(){
        $query = DB::select('CALL get_subSerie');
        return response()->json($query);
    }

    public function get_seccion_multi(){
        $query = DB::select('CALL get_seccion_multi');
        return response()->json($query);
    }
    public function get_subseccion_multi(){
        $query = DB::select('CALL get_subseccion_multi');
        return response()->json($query);
    }
    public function get_serie_all(){
        $query = DB::select('CALL get_serie_all');
        return response()->json($query);
    }
    

    public  function setProceedings(Request $request){
        $user_id = FacadesAuth::user()->id;
        $subSerieId = $request->subSerie;
        $name = $request->nameProceedings;
        $fileNumber = $request->fileNumber;
        $description = $request->comment;
        $openingDate = $request->openDate;
        $state = 'Público';
        $query = DB::insert('CALL set_proceedings (?,?,?,?,?,?,?)',[$user_id, $subSerieId,$name,$fileNumber,$description,$openingDate,$state]);
        return response()->json($query);
    }
    
    public  function setSeccion(Request $request){
        $user_id = FacadesAuth::user()->id;
        $sectionCode = $request->sectionCode;
        $name = $request->nameSeccion;
        $query = DB::insert('CALL set_seccion (?,?,?)',[$user_id,$sectionCode,$name]);
        return response()->json($query);
    }
    public  function setSubSeccion(Request $request){
        $user_id = FacadesAuth::user()->id;
        $sectionId = $request->sectionId;
        $subSectionCode = $request->subSectionCode;
        $name = $request->nameSubSeccion;
        $query = DB::insert('CALL set_subseccion (?,?,?,?)',[$user_id,$sectionId,$subSectionCode,$name]);
        return response()->json($query);
    }
    public  function setSerie(Request $request){
        $user_id = FacadesAuth::user()->id;
        $subSectionId = $request->subSectionId;
        $serieCode = $request->serieCode;
        $name = $request->nameSerie;
        $query = DB::insert('CALL set_serie (?,?,?,?)',[$user_id,$subSectionId,$serieCode,$name]);
        return response()->json($query);
    }
    public  function setSubSerie(Request $request){
        $user_id = FacadesAuth::user()->id;
        $serieId = $request->serieId;
        $subSerieCode = $request->subSerieCode;
        $name = $request->nameSubSerie;
        $query = DB::insert('CALL set_subserie (?,?,?,?)',[$user_id,$serieId,$subSerieCode,$name]);
        return response()->json($query);
    }

    public function getProccedingsAll(){
        $query = DB::select('CALL get_proceedings_all');
        return response()->json($query);
    }

    //-------------------------Subproceedings------------------------

    public function getProceedings(){
        $query = DB::select('CALL get_proceedings');
        return response()->json($query);
    }

    public function setSubProceedings(Request $request){
        $user_id = FacadesAuth::user()->id;
        $proceedingsId = $request->proceedingsId;
        $name = $request->nameSubProceedings;
        $subFileNumber = $request->subFileNumber;
        $description = $request->comment;
        $openingDate = $request->openDate;
        $state = 'Público';
        $query = DB::insert('CALL set_SubProceedings(?,?,?,?,?,?,?)',[$user_id,$proceedingsId,$name,$subFileNumber,$description,$openingDate,$state]);
        return response()->json($query);
    }

  

    //----------------Document----------------------------

    public function getSubProccedings($id){
        $query = DB::select('CALL get_SubProccedings(?)',[$id]);
        return response()->json($query);
    }
    public function get_subproccedings_all(){
        $query = DB::select('CALL get_subproccedings_all');
        return response()->json($query);
    }
    
    

    public function getDocument(){
        $query = DB::select('CALL get_document');
        return response()->json($query);
    }

    public function setDocumente(Request $request){
        $user_id = FacadesAuth::user()->id;
        $proceedingsId = $request->fileNumber;
        $subProceedingsId = $request->subFileNumber;
        $description = $request->comment;
        $name = $request->nameDocument;
        $documentCreationDate = $request->documentDate;
        $state = 'Abierto';
        $file = $request->file('file');
        $date = date('Y-m-d H:i:s');
        $date =  str_replace(":", "_", $date);
        $ext = $file->extension();
        if($ext == 'pdf'){
            if($subProceedingsId == 'undefined'){
                $subProceedingsId = null;
                $support = $proceedingsId.'-Expediente-'.$date.'.'.$ext;
                Storage::disk('expediente')->put($support, file_get_contents($file->getRealPath()));
                $query = DB::insert('CALL set_document(?,?,?,?,?,?,?,?)',[$user_id, $proceedingsId,$subProceedingsId,$description,$name,$documentCreationDate,$support,$state]);
            }else{
                $support = $subProceedingsId.'-Subexpediente-'.$date.'.'.$ext;
                Storage::disk('subexpediente')->put($support, file_get_contents($file->getRealPath()));
                $query = DB::insert('CALL set_document(?,?,?,?,?,?,?,?)',[$user_id, $proceedingsId,$subProceedingsId,$description,$name,$documentCreationDate,$support,$state]);
            }
        }
        else{
            $query = false;
        }
        return response()->json($query);
    }
 
//----------------Series----------------------------
public function getSerie(){
    $query = DB::select('CALL get_series');
    return response()->json($query);
}
//----------------Seccion----------------------------
public function getSeccion(){
    $query = DB::select('CALL get_seccions');
    return response()->json($query);
}
//----------------Subseccion----------------------------
public function getSubseccion(){
    $query = DB::select('CALL get_subsections');
    return response()->json($query);
}
//----------------Subserie----------------------------
public function getSubserie(){
    $query = DB::select('CALL get_subserie_all');
    return response()->json($query);
}
//----------------Subserie----------------------------
public function getDataAll(){
    $query = DB::select('CALL get_data_all');
    return response()->json($query);
}
//----------------Users----------------------------
public function getUsers(){
    $query = DB::select('CALL get_users');
    return response()->json($query);
}
public function getSeccionAll(){
    $query = DB::select('CALL get_seccion_all');
    return response()->json($query);
}

public function deleteproceedings(Request $request){
    $fileNumber = $request->fileNumber;
    $query = DB::delete('CALL delete_proceedings(?)',[$fileNumber]);
        return response()->json($query);
    
}

public function deletesubproceedings(Request $request){
    $subFileNumber = $request->subFileNumber;
    $query = DB::delete('CALL delete_subproceedings(?)',[$subFileNumber]);
        return response()->json($query);
    
}

public function deletedocument(Request $request){
    $name = $request->name;
    $query = DB::delete('CALL delete_document(?)',[$name]);
        return response()->json($query);
    
}

public function Logout(Request $request){
    $request->user()->token()->revoke();

    return response()->json([
       'message' => 'Successfully logged out'
    ]);
}
}
