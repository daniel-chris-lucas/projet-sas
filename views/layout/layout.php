<!DOCTYPE html>
<!--[if lt IE 7]>      <html class="no-js lt-ie9 lt-ie8 lt-ie7"> <![endif]-->
<!--[if IE 7]>         <html class="no-js lt-ie9 lt-ie8"> <![endif]-->
<!--[if IE 8]>         <html class="no-js lt-ie9"> <![endif]-->
<!--[if gt IE 8]><!--> <html class="no-js"> <!--<![endif]-->
    <head>
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
        <title><?= $title ?></title>
        <meta name="description" content="">
        <meta name="viewport" content="width=device-width">

        <!-- Place favicon.ico and apple-touch-icon.png in the root directory -->

        <link rel="stylesheet" href="css/flexslider.css">
        <link rel="stylesheet" href="css/style.css">
        <script src="js/vendor/modernizr-2.6.2.min.js"></script>
    </head>
    <body>
        <!--[if lt IE 7]>
            <p class="chromeframe">
                You are using an <strong>outdated</strong> browser. Please <a href="http://browsehappy.com/"> upgrade your browser</a> 
                or <a href="http://www.google.com/chromeframe/?redirect=true">activate Google Chrome Frame</a> to improve your experience.
            </p>
        <![endif]-->

        <!-- start page -->
        <div id="page_wrapper">
            <!-- start header -->
            <header>
                <h1><a href="index.php">Auto Prestige</a></h1>
            </header>
            <!-- end header -->
            
            <!-- start marque pane -->
            <?php include 'marque_pane.php' ?>
            <!-- end marque pane -->
            
            <?php if( !isset( $_REQUEST['page'] ) || $_REQUEST['page'] == 'home' ) : ?>
                <?php include 'slider.php' ?>
            <?php endif; ?>
            
            <!-- start main content -->
            <div id="main" role="main">
                <?php echo isset( $_REQUEST['marque'] ) ? "<h2>{$page_title}</h2>" : ""; ?>
                <?php include $content ?>
            </div>
            <!-- end main content -->
        </div>
        <!-- end page -->

        <script src="//ajax.googleapis.com/ajax/libs/jquery/1.8.2/jquery.min.js"></script>
        <script>window.jQuery || document.write('<script src="js/vendor/jquery-1.8.2.min.js"><\/script>')</script>
        <script src="js/plugins.js"></script>
        <script src="js/main.js"></script>
    </body>
</html>