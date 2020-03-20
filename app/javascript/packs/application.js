import Turbolinks from "turbolinks";
import Rails from "@rails/ujs";
import * as ActiveStorage from "@rails/activestorage";

Turbolinks.start();
Rails.start();
ActiveStorage.start();

import "channels";
import "controllers";
import "bootstrap";
