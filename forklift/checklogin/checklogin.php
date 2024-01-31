<!DOCTYPE html>
<html>
<head>
    <title>Auto Refresh JSON</title>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
</head>
<body>
    <div id="jsonContent"></div>

    <script>
    $(document).ready(function(){
        function loadJSON() {
            $.ajax({
                url: 'data.json',
                type: 'GET',
                dataType: 'json',
                success: function(data) {
                    
                    $('#jsonContent').html(JSON.stringify(data, null, 2));
                },
                error: function(xhr, status, error) {
                    console.error(error);
                },
                complete: function() {
                    setTimeout(loadJSON, 100); 
                }
            });
        }

        loadJSON(); 
    });
    </script>
</body>
</html>