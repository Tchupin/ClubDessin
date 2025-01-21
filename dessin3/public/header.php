<header>
    <nav>
        <div class="logo-container">
            <a href="index.php"><img src="logo.png" alt="Logo" class="logo"></a>
        </div>
        <ul class="nav-links">
            <li><a href="index.php">Accueil</a></li>
            <li><a href="about.php">À propos</a></li>
            <li><a href="contact.php">Contact</a></li>
            <li><a href="login.php">Connexion</a></li>
        </ul>
    </nav>
</header>

<style>
    /* Style du header */
    header {
        background-color: #4e73df;
        padding: 15px;
        position: relative;
        z-index: 10;
        width: 100%;
    }

    .logo-container {
        display: inline-block;
    }

    .logo {
        width: 50px;
        height: auto;
    }

    nav {
        display: flex;
        justify-content: space-between;
        align-items: center;
    }

    .nav-links {
        list-style-type: none;
        margin: 0;
        padding: 0;
        display: flex;
        gap: 20px;
    }

    .nav-links li {
        display: inline;
    }

    .nav-links a {
        color: white;
        text-decoration: none;
        font-size: 1.1em;
        font-weight: 500;
        padding: 5px 10px;
        border-radius: 5px;
        transition: background-color 0.3s;
    }

    .nav-links a:hover {
        background-color: #2e59d9;
    }
</style>
