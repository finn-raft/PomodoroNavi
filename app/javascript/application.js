// Entry point for the build script in your package.json
//= require rails-ujs
//= require jquery.turbolinks
//= require turbolinks
//= require_tree .
//= require navi
//= require timer
//= require icon_preview
import "@hotwired/turbo-rails"
import "./controllers"
import Turbolinks from "turbolinks"
Turbolinks.start()
import * as bootstrap from "bootstrap"
