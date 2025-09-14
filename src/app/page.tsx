"use client";
import Link from "next/link";
import { Menu } from "lucide-react";
import { LogIn } from "lucide-react";
import { useState } from "react";
import { Logs } from "lucide-react";

export default function Home() {
  const [isMenuClicked, setIsMenuClicked] = useState(false);
  return (
    <>
      <div className="bg-gray-200 h-48 flex justify-evenly items-center gap-5">
        <form className="h-fit" action="/cities" method="GET">
          <input
            className="bg-white rounded-xl h-8 p-2"
            placeholder="search city"
            type="search"
          />
        </form>
        <div className="relative">
          <button
            onClick={() => setIsMenuClicked(!isMenuClicked)}
            className="bg-white p-2 rounded-full hover:cursor-pointer hover:bg-gray-100"
          >
            {isMenuClicked ? <Logs></Logs> : <Menu></Menu>}
          </button>
          {isMenuClicked && (
            <div className="absolute -left-5  w-fit h-fit bg-white p-2 rounded-lg flex flex-col mt-2 border-2 border-gray-100 shadow">
              <Link
                className="border-b-2 border-gray-100 rounded-lg hover:bg-gray-100 text-center"
                href={"/profile"}
              >
                profile
              </Link>
              <Link
                className="border-b-2 border-gray-100 rounded-lg hover:bg-gray-100 text-center"
                href={"/register"}
              >
                register
              </Link>
            </div>
          )}
        </div>
        <button className="bg-green-100 p-2 rounded-full hover:cursor-pointer hover:bg-green-200">
          <LogIn></LogIn>
        </button>
      </div>
    </>
  );
}
