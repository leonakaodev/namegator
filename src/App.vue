<template>
    <div>
        <div id="slogan" class="text-center">
            <h1>NameGator</h1>
            <br>
            <h6 class="text-secondary">Gerando nomes utlizando Vue.js, GraphQL e Node</h6>  
        </div>
        <DomainList></DomainList>
    </div>
</template>

<script>
import "bootstrap/dist/css/bootstrap.css";
import "font-awesome/css/font-awesome.css";
import DomainList from "./components/DomainList";

export default {
	name: "App",
	data: function(){
		return {
			prefixes: ["Air", "Jet", "Flight"],
			sufixes: ["Hub", "Station", "Mart"],
		};
	},
	components: {
		DomainList
	},
	computed: {
		domains(){
			let domains = [];

			for(const prefix of this.prefixes){
				for(const sufix of this.sufixes){
					const name = prefix+sufix;
					const url = name.toLowerCase();
					const checkout = `https://checkout.hostgator.com.br/?a=add&sld=${url}&tld=.com.br`;
					domains.push({
						name,
						checkout
					});
				}
			}

			return domains; 
		}
	},
	methods: {
		addPrefix: function(prefix){
			this.prefixes.push(prefix);
		},
		addSufix: function(sufix){
			this.sufixes.push(sufix);
		},
		deletePrefix: function(prefix){
			this.prefixes.splice(this.prefixes.indexOf(prefix), 1);
		},
		deleteSufix: function(sufix){
			this.sufixes.splice(this.prefixes.indexOf(sufix), 1);
		}
	}
};
</script>

<style>
#slogan {
    margin-top: 30px;
    margin-bottom: 30px;
}


#main {
	background-color: #E7E7E7;
    padding-top: 30px;
    padding-bottom: 30px;
}
</style>