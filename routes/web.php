<?php

/*
|--------------------------------------------------------------------------
| Web Routes
|--------------------------------------------------------------------------
|
| Here is where you can register web routes for your application. These
| routes are loaded by the RouteServiceProvider within a group which
| contains the "web" middleware group. Now create something great!
|
*/
use App\Http\Controllers\DatosController;
//use Illuminate\Routing\Route;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Route;

Route::get('/', function () {
    return view('auth.login');
});

Auth::routes(['register'=>false]);
Route::group(['middleware' => ['auth']], function () {
    Route::view('/home', 'home');
    Route::view('/CrearDocumento', 'home')->name('crearDocumento');
    Route::view('/crearExpediente', 'home')->name('crearExpediente');
    Route::view('/CrearSubexpediente', 'home')->name('crearSubexpediente');
    Route::view('/inventario', 'home')->name('inventario');
    Route::view('/MenuDocumentos', 'home')->name('MenuDocumentos');
    Route::view('/CrearSeries', 'home')->name('CrearSeries');
    Route::view('/CrearSeccion', 'home')->name('CrearSeccion');
    Route::view('/CrearSubSeccion', 'home')->name('CrearSubSeccion');
    Route::view('/CrearSubSeries', 'home')->name('CrearSubSeries');
    Route::view('/usuarios', 'home')->name('usuarios');
    
    Route::view('/Content', 'home')->name('content');
    
    Route::get('/Logout', 'HomeController@Logout');

    Route::get('/getUser','UsersController@getUser');
    Route::get('/getUsers', 'UsersController@getUsers');
    Route::get('/getDocumentTypes', 'UsersController@getDocumentTypes');
    Route::get('/getPositions', 'UsersController@getPositions');
    Route::get('/getRoles', 'UsersController@getRoles');

    Route::post('/setUserNew', 'UsersController@setUserNew');

    

    Route::get('/getSeccions', 'DocumentController@getSeccions');
    Route::get('/prueba', 'DatosController@index');
    Route::get('/getProccedingsAll', 'DocumentController@getProccedingsAll');
    Route::get('/getSerie', 'DocumentController@getSerie');
    Route::get('/getSeccion', 'DocumentController@getSeccion');
    Route::get('/getSubseccion', 'DocumentController@getSubseccion');
    Route::get('/getSubserie', 'DocumentController@getSubserie');
    Route::get('/getDataAll', 'DocumentController@getDataAll');
    Route::get('/getProceedings', 'DocumentController@getProceedings');
    Route::get('/getSubproceedingsAll', 'DocumentController@getSubproceedingsAll');
    Route::get('/getDocument', 'DocumentController@getDocument');
    Route::get('/get_seccion_multi', 'DocumentController@get_seccion_multi');
    Route::get('/get_subseccion_multi', 'DocumentController@get_subseccion_multi');
    Route::get('/getSeccionAll', 'DocumentController@getSeccionAll');
    Route::get('/get_serie_all', 'DocumentController@get_serie_all');
    Route::get('/get_subproccedings_all', 'DocumentController@get_subproccedings_all');
    
    
    
    
    
    Route::get('/getSubProccedings/{id}', 'DocumentController@getSubProccedings');
    
    Route::post('/setProceedings', 'DocumentController@setProceedings');
    Route::post('/setSeccion', 'DocumentController@setSeccion');
    Route::post('/setSubSeccion', 'DocumentController@setSubSeccion');
    Route::post('/setSerie', 'DocumentController@setSerie');
    Route::post('/setSubSerie', 'DocumentController@setSubSerie');
    Route::post('/setSubProceedings', 'DocumentController@setSubProceedings');
    Route::post('/setDocumente', 'DocumentController@setDocumente');
    Route::delete('/deleteproceedings/{fileNumber}', 'DocumentController@deleteproceedings');
    Route::delete('/deletesubproceedings/{subFileNumber}', 'DocumentController@deletesubproceedings');
    Route::delete('/deletedocument/{name}', 'DocumentController@deletedocument');

   
});
