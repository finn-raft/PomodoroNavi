// Entry point for the build script in your package.json
//= require jquery.turbolinks
//= require turbolinks
//= require navi
import "@hotwired/turbo-rails"
import "./controllers"
import Turbolinks from "turbolinks"
Turbolinks.start()
import * as bootstrap from "bootstrap"
