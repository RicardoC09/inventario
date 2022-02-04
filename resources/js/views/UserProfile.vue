 <template>
 <div>
    <base-header type="gradient-success" class="pb-6 pb-8 pt-5 pt-md-8">
        <!-- Card stats -->
        <div class="row">
        </div>
    </base-header>

    <div class="container">
        <div class="row">
            <div class="col-12 my-3 pt-3 shadow">
                <img :src="'avatar/' + avatar" width="100" height="100" class="float-left rounded-circle mr-2">
            	<h1>{{ nameUser }}</h1>
            	<h3>{{ email_user }}</h3>
                <p>
                    <strong>{{taypeDocument}}</strong>: {{ number }} <br>
                    <strong>Cargo</strong>: {{ positionUser}} <br>
                </p>
                <hr>
                <p>
                    <strong>Rol</strong>: {{ rol }}
                </p>

                <hr>
                <!-- <p>
                    <b-button v-b-modal.modal_user>Editar perfil</b-button>
                </p> -->
                    
                    
            </div>
        </div>
    </div>
    <b-modal v-model="modal_user" id="modal_user" size="lg" hide-footer>
            <div class="card">
                <!-- <div class="card-header">
                    <div class="card-title"><h3>Editar Perfil</h3></div>
                </div> -->
                <div class="card-body">
                    <b-form>
                        <div class="row">
                            <div class="col">
                                <div class="form-group">
                                    <label for="documenType">Tipo de Documento:</label>
                                    <multiselect v-model="documenType"
                                                 id="documenType"
                                                 placeholder="Seleccione el tipo de documento"
                                                 :options="options_documenType"
                                                 label="name">
                                    </multiselect>
                                </div>
                                <div class="form-group">
                                    <label for="documentNunber">Numero de documento:</label>
                                    <input type="text"
                                           id="documentNunber"
                                           v-model="number"
                                           class="form-control">
                                </div>
                                <div class="form-group">
                                    <label for="name">Nombre y Apellidos:</label>
                                    <input type="text"
                                           id="name"
                                           v-model="nameUser"
                                           class="form-control">
                                </div>
                                 <div class="form-group">
                                    <label for="email">Email:</label>
                                    <b-form-input type="email"
                                           id="email"
                                           v-model="email_user">
                                    </b-form-input>
                                </div>
                                <div class="form-group">
                                    <label for="rolType">Seleccione el Rol:</label>
                                    <multiselect v-model="rolType"
                                                 placeholder="Seleccione el Rol"
                                                 :options="options_rolType"
                                                 label="name"
                                                 id="rolType">
                                    </multiselect>
                                </div>
                            </div>
                            <div class="col">
                                <div class="form-group">
                                    <label for="position">Seleccione el Cargo:</label>
                                    <multiselect v-model="position"
                                                 placeholder="Seleccione el cargo"
                                                 :options="options_position"
                                                 label="name"
                                                 id="position">
                                    </multiselect>
                                </div>

                                <div>
                                    <b-form-group id="fieldset-6" label="Nueva imagen:">
                                        <b-form-file
                                            v-model="file"
                                            :state="Boolean(file)"
                                            placeholder="Choose a file or drop it here..."
                                            drop-placeholder="Drop file here..."
                                            @change="fileChange">>
                                        </b-form-file>
                                    </b-form-group>
                                </div>                  
                                <div class="container-button">
                                    
                                    <b-button class="btn-form-submit" @click="setUserNew">Editar</b-button>
                                </div>
                            </div>
                        </div>
                    </b-form>
                </div>
            </div>
        </b-modal>
</div>
</template>
<script>
    import VueBootstrap4Table from "vue-bootstrap4-table";
    import Multiselect from 'vue-multiselect';
    import swal from 'sweetalert';
    import axios from 'axios';
     
    export default {
        mounted() {
           this.listUser();
           this.listUsers();
           this.listDocumentTypes();
           this.listPositions();
           this.listRoles();
        },
        components: {Multiselect, swal, VueBootstrap4Table},
        name: "Usuarios",
        data() {
            return {
                modal_user: false,
                documenType:'',
                rolType:'',
                documentNunber:'',
                position:'',
                name:'',
                email:'',
                password:'',
                password1:'',
                file:null,
                nameUser:'',
                idPeple:'',
                taypeDocument:'',
                number:'',
                rol:'',
                rolId:'',
                positionUser:'',
                cargo:'',
                email_user:'',
                avatar:'',
                contraseña:'Las contraseñas no son iguales',


                options_documenType:[],
                options_rolType:[],
                options_position:[],

                rows_users: [],
                columns_users: [
                    {
                        label: "ID",
                        name: "id",
                    },
                    {
                        label: "Nombre",
                        name: "name",
                        sort: true,
                    },
                    {
                        label: "Email",
                        name: "email",
                    },
                ],
                config: {
                    show_refresh_button: false,
                    show_reset_button: false,
                    card_mode: false,
                    per_page: 5,
                },
                classes: {
                    table: {
                        "table table-striped table-striped-bg-default mt-3": true,
                    },
                },
            };
        },
        methods: {
             messageAlert: function (state, title, msj) {
                this.$swal({
                    type: state,
                    title: title,
                    text: msj
                });
            },
            listUser:function (){
                axios.get('/getUser').then(response => {
                    let data = response.data;
                    for(let i in data){
                        this.idPeple= data[i].idPeple;
                        this.taypeDocument= data[i].taypeDocument;
                        this.number= data[i].number;
                        this.rol= data[i].rol;
                        this.rolId= data[i].rolId;
                        this.positionUser= data[i].position;
                        this.cargo= data[i].cargo;
                        this.email_user= data[i].email;
                        this.avatar= data[i].avatar;
                        this.nameUser = data[i].nameUser;
                    }
                     }).catch(e => {
                    console.log(e.response);
                });
            },
            listUsers:function (){
                axios.get('/getUsers').then(response => {
                    let data = response.data;
                    for (let i in data){
                        this.rows_users.push({
                            'id': data[i].idPeple,
                            'name': data[i].nameUser,
                            'email': data[i].email,
                        });
                    }
                }).catch(e => {
                    console.log(e.response);
        
                });
            },
            listDocumentTypes: function () {
                axios.get('/getDocumentTypes').then(response => {
                    let data = response.data;
                    console.log('Yo Soy el que soy');
                    console.log(data);
                    for (let i in data) {
                        this.options_documenType.push({
                            'id': data[i].id,
                            'name': data[i].name,
                        });
                    }
                }).catch(e => {
                    console.log(e.response);
                });
            },
            listPositions: function () {
                axios.get('/getPositions').then(response => {
                    let data = response.data;
                    for (let i in data) {
                        this.options_position.push({
                            'id': data[i].id,
                            'name': data[i].name,
                        });
                    }
                }).catch(e => {
                    console.log(e.response);
                });
            },
            listRoles: function () {
                axios.get('/getRoles').then(response => {
                    let data = response.data;
                    for (let i in data) {
                        this.options_rolType.push({
                            'id': data[i].id,
                            'name': data[i].name,
                        });
                    }
                }).catch(e => {
                    console.log(e.response);
                });
            },

            fileChange: function (e) {
                this.file = e.target.files[0];
            },

             
        },
    };
</script>
<style scoped>
    .bg-gradient-success {
        background: linear-gradient(87deg, #8f141b 0, #8f141b 100%) !important;
    }

    .bg-secondary {
        background-color: #fff !important;
    }
    .btn-form-submit {
        background-color: #8f141b;
        color: #dfd4a6;
        border-radius: 20px;
        width: 30%;
    }

    .btn-form-cancel {
        background-color: #dfd4a6;
        color: #8f141b;
        border-radius: 20px;
        width: 30%;
    }
     .form-group-left {
        width: 60%;
        text-align: left;
    }
    .row {
    display: flex;
    flex-wrap: wrap;
    margin-right: -15px;
    margin-left: -15px;
    }
    .form-group-right {
        width: 100%;
        text-align: left;
    }
    .main-content .container-fluid, .main-content .container-sm, .main-content .container-md, .main-content .container-lg, .main-content .container-xl {
    padding-left: 100px !important;
    padding-right: 3px !important;
    padding-top:15px;
    }
    .container-right {
        float: right;
        width: 50%;
    }

    .container-left {
        float: left;
        width: 50%;
    }

    .container-button {
        position: relative;
        top: 25px;
        text-align: center;
    }

    .header-left {
        float: left;
        font-size: 1rem;
        font-weight: 400;
        line-height: 1.5;
        color: #525f7f;
    }

    .header-right {
        float: right;
        font-size: 1rem;
        font-weight: 400;
        line-height: 1.5;
        color: #525f7f;
    }

</style>
